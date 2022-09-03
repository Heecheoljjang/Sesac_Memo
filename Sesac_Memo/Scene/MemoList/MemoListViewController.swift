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
            print(tasks.count)
            title = "\(tasks.count)개의 메모"
            self.mainView.tableView.reloadData()
        }
    }
        
    let resultVC = SearchViewController()
    
    private let userDefaults = UserDefaults.standard
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpController()
        
        print(Calendar.current.dateComponents([.day, .year, .month], from: Date()))
        
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
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true)

        }
    }
    
    override func configure() {
        super.configure()
        
        
    }
    
    //MARK: 네비게이션, 툴바 등 뷰컨트롤러 기본 세팅
    override func setUpController() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        //네비게이션바 설정
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.backButtonTitle = "메모"
        
        //서치 컨트롤러 적용 자료
        let searchController = UISearchController(searchResultsController: resultVC)
        searchController.searchBar.placeholder = "검색"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.tintColor = .systemOrange
        searchController.searchResultsUpdater = self
        resultVC.mainView.tableView.delegate = self
        resultVC.mainView.tableView.dataSource = self
        navigationItem.searchController = searchController
        
        //툴바 적용
        navigationController?.isToolbarHidden = false
        navigationController?.toolbar.tintColor = .systemOrange
        navigationController?.toolbar.backgroundColor = .systemGray6
        let addMemoButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(presentWritingView))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [flexibleSpace, addMemoButton]
    }
    
    //MARK: - @objc
    
    @objc private func presentWritingView() {
        let vc = WritingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
