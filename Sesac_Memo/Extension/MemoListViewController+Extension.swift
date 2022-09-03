//
//  MemoListViewController+Extension.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation
import UIKit

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == mainView.tableView {
            if tasks.filter("isFixed == true").count == 0 {
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
            if tasks.filter("isFixed == true").count == 0 {
                return tasks.filter("isFixed == false").count
            } else {
                if section == 0 {
                    return tasks.filter("isFixed == true").count
                } else {
                    return tasks.filter("isFixed == false").count
                }
            }
        } else {
            return resultVC.tasks.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mainView.tableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.identifier, for: indexPath) as? MemoListTableViewCell else { return UITableViewCell() }
            
            let fixedTasks = tasks.filter("isFixed == true")
            let notFixedTasks = tasks.filter("isFixed == false")
            
            if fixedTasks.count == 0 {
                cell.titleLabel.text = notFixedTasks[indexPath.row].memoTitle
                cell.bottomLabel.text = notFixedTasks[indexPath.row].registerDate.checkDate() + "   " + notFixedTasks[indexPath.row].memoContent
            } else {
                if indexPath.section == 0 {
                    cell.titleLabel.text = fixedTasks[indexPath.row].memoTitle
                    cell.bottomLabel.text = fixedTasks[indexPath.row].registerDate.checkDate() + "   " + fixedTasks[indexPath.row].memoContent
                } else {
                    cell.titleLabel.text = notFixedTasks[indexPath.row].memoTitle
                    cell.bottomLabel.text = notFixedTasks[indexPath.row].registerDate.checkDate() + "   " + notFixedTasks[indexPath.row].memoContent
                }
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
            
            cell.titleLabel.text = resultVC.tasks[indexPath.row].memoTitle
            cell.bottomLabel.text = resultVC.tasks[indexPath.row].registerDate.checkDate() + "   " + resultVC.tasks[indexPath.row].memoContent
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == mainView.tableView {
            if tasks.filter("isFixed == true").count == 0 {
                return "메모"
            } else {
                if section == 0 {
                    return "고정된 메모"
                } else {
                    return "메모"
                }
            }
        } else {
            return "\(resultVC.tasks.count)개 찾음"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }

    //삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let fixedTasks = tasks.filter("isFixed == true")
        let notFixedTasks = tasks.filter("isFixed == false")
        
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            if tableView == self.mainView.tableView {
                if fixedTasks.count == 0 {
                    self.checkCancel(memo: notFixedTasks[indexPath.row])
                } else {
                    if indexPath.section == 0 {
                        self.checkCancel(memo: fixedTasks[indexPath.row])
                    } else {
                        self.checkCancel(memo: notFixedTasks[indexPath.row])
                    }
                }
            } else {
                self.resultVC.checkCancel(memo: self.resultVC.tasks[indexPath.row]) {
                    self.tasks = self.repository.fetch()
                    self.mainView.tableView.reloadData()
                }
            }
        }
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    //고정
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let fixedTasks = tasks.filter("isFixed == true")
        let notFixedTasks = tasks.filter("isFixed == false")
        
        let fix = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            
            if tableView == self.mainView.tableView {
                if fixedTasks.count == 0 {
                    self.repository.updateIsFixed(memo: notFixedTasks[indexPath.row])
                } else {
                    if indexPath.section == 0 {
                        self.repository.updateIsFixed(memo: fixedTasks[indexPath.row])
                    } else {
                        if fixedTasks.count < 5 {
                            self.repository.updateIsFixed(memo: notFixedTasks[indexPath.row])
                        } else {
                            self.showFixAlert(title: "알림", message: "고정은 최대 5개까지만 가능합니다!")
                        }
                    }
                }
                self.mainView.tableView.reloadData()
            } else {
                self.resultVC.repository.updateIsFixed(memo: self.resultVC.tasks[indexPath.row])
                self.resultVC.mainView.tableView.reloadData()
            }
            self.tasks = self.repository.fetch()
            self.mainView.tableView.reloadData()
        }
        if tableView == mainView.tableView {
            if fixedTasks.count == 0 {
                fix.image = UIImage(systemName: "pin.fill")
            } else {
                let image = indexPath.section == 0 ? "pin.slash.fill" : "pin.fill"
                fix.image = UIImage(systemName: image)
            }
        } else {
            fix.image = resultVC.tasks[indexPath.row].isFixed ? UIImage(systemName: "pin.slash.fill") : UIImage(systemName: "pin.fill")
        }
        
        fix.backgroundColor = .systemOrange
        return UISwipeActionsConfiguration(actions: [fix])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WritingViewController()
        let fixedTasks = tasks.filter("isFixed == true")
        let notFixedTasks = tasks.filter("isFixed == false")
        
        if tableView == mainView.tableView {
            if indexPath.section == 0 {
                vc.currentTask = fixedTasks[indexPath.row]
                vc.mainView.textView.text = fixedTasks[indexPath.row].memoTitle + "\n" + fixedTasks[indexPath.row].memoContent
            } else {
                vc.currentTask = notFixedTasks[indexPath.row]
                vc.mainView.textView.text = notFixedTasks[indexPath.row].memoTitle + "\n" + notFixedTasks[indexPath.row].memoContent
            }
            navigationItem.backButtonTitle = "메모"
            navigationController?.pushViewController(vc, animated: true)
        } else {
            vc.currentTask = resultVC.tasks[indexPath.row]
            vc.mainView.textView.text = resultVC.tasks[indexPath.row].memoTitle + "\n" + resultVC.tasks[indexPath.row].memoContent
            navigationItem.backButtonTitle = "검색"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        resultVC.tasks = repository.fetchSearch(keyword: text)
        resultVC.mainView.tableView.reloadData()
    }
}

extension MemoListViewController {
    
    private func showFixAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    private func checkCancel(memo: UserMemo) {
        let alert = UIAlertController(title: "메모를 제거하시겠습니까??", message: "삭제하시면 다시 되돌릴 수 없습니다!!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
            self.repository.deleteMemo(memo: memo)
            self.title = "\(self.tasks.count)개의 메모"
            self.mainView.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
