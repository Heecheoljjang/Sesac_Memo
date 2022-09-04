//
//  MemoListViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation
import UIKit
import RealmSwift

final class MemoListViewController: BaseViewController {
    
    var mainView = MemoListView()
    
    var repository = UserMemoRepository()

    var tasks: Results<UserMemo>! {
        didSet {
            title = "\(numberSetting(number: tasks.count))개의 메모"
            self.mainView.tableView.reloadData()
        }
    }
        
    let resultVC = SearchViewController()
    
    var searchKeyword = ""
    
    private let userDefaults = UserDefaults.standard
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tasks = repository.fetch() // pop될 때도 적용되어야함
        
        navigationController?.navigationBar.prefersLargeTitles = true // 작성화면의 라지타이틀 안쓴다는 내용이 적용돼서 매번 작성해줘야함.

        mainView.tableView.reloadData()
    }
    
    //MARK: 팝업 화면 띄우기
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if userDefaults.bool(forKey: "isFirst") == false {
            
            let vc = PopUpViewController()
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)

        }
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
        //navigationController?.toolbar.backgroundColor = .systemBackground
        
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
        navigationItem.backButtonTitle = "메모 "
        navigationController?.pushViewController(vc, animated: true)
    }
}
