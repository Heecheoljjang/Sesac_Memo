//
//  MemoListViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation
import UIKit
import RealmSwift
import RxSwift

final class MemoListViewController: BaseViewController {
    
    var mainView = MemoListView()
    
    let viewModel = MemoListViewModel()
    
    let disposeBag = DisposeBag()
     
    let resultVC = SearchViewController()
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //tasks의 값이 바뀌면 내부 코드 실행
        viewModel.tasks
            .bind(onNext: { [weak self] memo in
                self?.title = "\(self!.viewModel.numberSetting(number: memo.count))개의 메모"
                self?.mainView.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.searchKeyword
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] value in
                //resultVC의 tasks값 onNext로 바뀌고, 바인드된 코드로 테이블뷰 리로드
                self?.resultVC.viewModel.fetchSearch(keyword: value)
                self?.resultVC.mainView.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchMemo() // 리로드 코드는 바인드되어있어서 실행됨
                
        navigationController?.navigationBar.prefersLargeTitles = true // 작성화면의 라지타이틀 안쓴다는 내용이 적용돼서 매번 작성해줘야함.

//        mainView.tableView.reloadData()
    }
    
    //MARK: 팝업 화면 띄우기
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if viewModel.checkFirst() {
            
            let vc = PopUpViewController()
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
            
        }
        emptyDelete()
    }

    private func emptyDelete() {
        //가장 최근 작성된 메모가 제목, 내용이 전부 ""라면 삭제

        viewModel.emptyDelete() // fetchMemo실행되면 task바뀌어서 리로드 실행됨
    }
    
    //MARK: 네비게이션, 툴바 등 뷰컨트롤러 기본 세팅
    override func setUpController() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        navigationItem.backButtonTitle = "메모"

        //서치 컨트롤러 적용
        let searchController = UISearchController(searchResultsController: resultVC)
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.tintColor = .systemOrange
        searchController.searchResultsUpdater = self
        resultVC.mainView.tableView.delegate = self
        resultVC.mainView.tableView.dataSource = self
        navigationItem.searchController = searchController
        
        //툴바 적용
        navigationController?.toolbar.tintColor = .systemOrange
        
        let addMemoButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(presentWritingView))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [flexibleSpace, addMemoButton]
    }
    
    override func setUpNavigationBarColor() {
        
        navigationController?.isToolbarHidden = false
        
        switch self.traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            mainView.backgroundColor = .systemGray6 //커스텀뷰 클래스에서 하면 적용이안되는듯.
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemGray6
            appearance.shadowColor = .clear
            
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.toolbar.backgroundColor = .systemGray6
        case .dark:
            mainView.backgroundColor = .systemBackground
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            appearance.shadowColor = .clear
            
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.toolbar.backgroundColor = .systemBackground
        }
    }
    
    //MARK: - @objc
    
    @objc private func presentWritingView() {
        let vc = WritingViewController()
        vc.isNew = true
        
        //메모 생성 후 전달
        viewModel.addMemo()
        
        vc.currentTask = viewModel.fetchFirst() // 가장 최근
        
        navigationItem.backButtonTitle = "메모 "
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == mainView.tableView {
//            if tasks.filter("isFixed == true").count == 0 {
            if viewModel.checkFilteredCount(isFixed: true, count: 0) {
                return 1
            } else {
                return 2
            }
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainView.tableView {
            if viewModel.checkFilteredCount(isFixed: true, count: 0) {
                return viewModel.fetchFilteredCount(isFixed: false)
            } else {
                if section == 0 {
                    return viewModel.fetchFilteredCount(isFixed: true)
                } else {
                    return viewModel.fetchFilteredCount(isFixed: false)
                }
            }
        } else {
//            return resultVC.tasks.count
//            return resultVC.viewModel.fetchMemoCount()
            return resultVC.viewModel.fetchCurrentCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mainView.tableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.identifier, for: indexPath) as? MemoListTableViewCell else { return UITableViewCell() }
            
            let fixedTasks = viewModel.fetchIsFixed(isFixed: true)
            let notFixedTasks = viewModel.fetchIsFixed(isFixed: false)
            
            //제목도 앞부분에 공백이 있는경우 없애주기 - trim사용
//            if fixedTasks.count == 0 {
            if viewModel.checkFilteredCount(isFixed: true, count: 0) {
                cell.titleLabel.text = notFixedTasks[indexPath.row].title.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "새로운 메모" : notFixedTasks[indexPath.row].title.trimmingCharacters(in: .whitespacesAndNewlines)
                //내용이 비어있는 경우엔 추가 텍스트 없음으로 보여주기
                cell.bottomLabel.text = notFixedTasks[indexPath.row].memoContent == "" ?  notFixedTasks[indexPath.row].registerDate.checkDate() + "   추가 텍스트 없음" : notFixedTasks[indexPath.row].registerDate.checkDate() + "   " + notFixedTasks[indexPath.row].memoContent.trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                if indexPath.section == 0 {
                    cell.titleLabel.text = fixedTasks[indexPath.row].title.trimmingCharacters(in: .whitespacesAndNewlines)
                    cell.bottomLabel.text = fixedTasks[indexPath.row].memoContent == "" ?  fixedTasks[indexPath.row].registerDate.checkDate() + "   추가 텍스트 없음" : fixedTasks[indexPath.row].registerDate.checkDate() + "   " + fixedTasks[indexPath.row].memoContent.trimmingCharacters(in: .whitespacesAndNewlines)

                } else {
                    cell.titleLabel.text = notFixedTasks[indexPath.row].title.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "새로운 메모" : notFixedTasks[indexPath.row].title.trimmingCharacters(in: .whitespacesAndNewlines)
                    cell.bottomLabel.text = notFixedTasks[indexPath.row].memoContent == "" ?  notFixedTasks[indexPath.row].registerDate.checkDate() + "   추가 텍스트 없음" : notFixedTasks[indexPath.row].registerDate.checkDate() + "   " + notFixedTasks[indexPath.row].memoContent.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
            return cell
        } else {
            //텍스트 색 바꿔줘야함.
            //키워드를 알아야하기때문에 변수에 저장해놓고 그 부분을 찾아서 색바꾸는 방향으로 해봐야할듯 -> 될 지 모름
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
            
            //키워드 색 변경
//            let titleText = resultVC.tasks[indexPath.row].title.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let titleText = resultVC.viewModel.fetchTask()[indexPath.row].title.trimmingCharacters(in: .whitespacesAndNewlines)
//            let bottomText = resultVC.tasks[indexPath.row].registerDate.checkDate() + "   " + resultVC.tasks[indexPath.row].memoContent.trimmingCharacters(in: .whitespacesAndNewlines)
            let bottomText = resultVC.viewModel.fetchTask()[indexPath.row].registerDate.checkDate() + "   " + resultVC.viewModel.fetchTask()[indexPath.row].memoContent.trimmingCharacters(in: .whitespacesAndNewlines)

            cell.titleLabel.attributedText = changeKeywordColor(titleText, keyword: viewModel.searchKeyword.value)
            cell.bottomLabel.attributedText = changeKeywordColor(bottomText, keyword: viewModel.searchKeyword.value)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == mainView.tableView {
            if viewModel.checkFilteredCount(isFixed: true, count: 0) {
                return "메모"
            } else {
                if section == 0 {
                    return "고정된 메모"
                } else {
                    return "메모"
                }
            }
        } else {
            return "\(resultVC.viewModel.fetchCurrentCount())개 찾음"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }

    //삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let fixedTasks = viewModel.fetchIsFixed(isFixed: true)
        let notFixedTasks = viewModel.fetchIsFixed(isFixed: false)
        
        let delete = UIContextualAction(style: .normal, title: nil) { [weak self] action, view, completionHandler in
            if tableView == self?.mainView.tableView {
                if self!.viewModel.checkFilteredCount(isFixed: true, count: 0) {
                    self?.checkCancel(memo: notFixedTasks[indexPath.row])
                } else {
                    if indexPath.section == 0 {
                        self?.checkCancel(memo: fixedTasks[indexPath.row])
                    } else {
                        self?.checkCancel(memo: notFixedTasks[indexPath.row])
                    }
                }
            } else {
                self?.resultVC.checkCancel(memo: self!.resultVC.viewModel.fetchTask()[indexPath.row]) {
                    //self?.viewModel.fetchMemo()
                    //self?.mainView.tableView.reloadData()
                }
                
            }
        }
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    //고정
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let fixedTasks = viewModel.fetchIsFixed(isFixed: true)
        let notFixedTasks = viewModel.fetchIsFixed(isFixed: false)
        
        let fix = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            if tableView == self.mainView.tableView {
                if self.viewModel.checkFilteredCount(isFixed: true, count: 0) {
//                    self.repository.updateIsFixed(memo: notFixedTasks[indexPath.row])
                    self.viewModel.updateIsFixed(memo: notFixedTasks[indexPath.row])
                } else {
                    if indexPath.section == 0 {
                        self.viewModel.updateIsFixed(memo: fixedTasks[indexPath.row])
                    } else {
                        if fixedTasks.count < 5 {
                            self.viewModel.updateIsFixed(memo: notFixedTasks[indexPath.row])
                        } else {
                            self.showFixAlert(title: "알림", message: "고정은 최대 5개까지만 가능합니다!")
                        }
                    }
                }
            } else {
                self.resultVC.viewModel.updateIsFixed(memo: self.resultVC.viewModel.fetchTask()[indexPath.row])
            }
            
        }
        fix.backgroundColor = .systemOrange
        if tableView == mainView.tableView {
            if viewModel.checkFilteredCount(isFixed: true, count: 0) {
                fix.image = UIImage(systemName: "pin.fill")
            } else {
                let image = indexPath.section == 0 ? "pin.slash.fill" : "pin.fill"
                fix.image = UIImage(systemName: image)
            }
        } else {
            fix.image = resultVC.viewModel.fetchTask()[indexPath.row].isFixed ? UIImage(systemName: "pin.slash.fill") : UIImage(systemName: "pin.fill")
        }
        return UISwipeActionsConfiguration(actions: [fix])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WritingViewController()
        let fixedTasks = viewModel.fetchIsFixed(isFixed: true)
        let notFixedTasks = viewModel.fetchIsFixed(isFixed: false)
        
        if tableView == mainView.tableView {
            if viewModel.checkFilteredCount(isFixed: true, count: 0) {
                vc.currentTask = notFixedTasks[indexPath.row]
                vc.mainView.textView.text = notFixedTasks[indexPath.row].title + notFixedTasks[indexPath.row].memoContent
            } else {
                if indexPath.section == 0 {
                    vc.currentTask = fixedTasks[indexPath.row]
                    vc.mainView.textView.text = fixedTasks[indexPath.row].title + fixedTasks[indexPath.row].memoContent
                } else {
                    vc.currentTask = notFixedTasks[indexPath.row]
                    vc.mainView.textView.text = notFixedTasks[indexPath.row].title + notFixedTasks[indexPath.row].memoContent
                }
            }
            vc.isNew = false
            navigationItem.backButtonTitle = "메모"
            navigationController?.pushViewController(vc, animated: true)
        } else {
            vc.isNew = false
            vc.currentTask = resultVC.viewModel.fetchTask()[indexPath.row]
            vc.mainView.textView.text = resultVC.viewModel.fetchTask()[indexPath.row].title + resultVC.viewModel.fetchTask()[indexPath.row].memoContent
            navigationItem.backButtonTitle = "검색"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.mainView.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel(frame: CGRect(x: 4, y: 0, width: UIScreen.main.bounds.width - 40, height: 30))
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        let view = UIView()
        view.addSubview(label)
        
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        //키워드 색 변경을 위해 변수에 저장
//        searchKeyword = text
//        resultVC.tasks = repository.fetchSearch(keyword: text)
//        resultVC.mainView.tableView.reloadData()
        
        viewModel.setSearchKeyword(keyword: text)
    }
}

extension MemoListViewController {
    
    //UI
    private func showFixAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    //UI
    private func checkCancel(memo: UserMemo) {
        let alert = UIAlertController(title: "메모를 제거하시겠습니까??", message: "삭제하시면 다시 되돌릴 수 없습니다!!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteMemo(memo: memo) //바인드된 코드 같이 실행됨
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }

    //UI
    private func changeKeywordColor(_ string: String, keyword: String) -> NSMutableAttributedString {
        let beforeString = (string.lowercased() as NSString).range(of: keyword.lowercased())
        let attributedString = NSMutableAttributedString.init(string: string)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: beforeString)
        return attributedString
    }
}
