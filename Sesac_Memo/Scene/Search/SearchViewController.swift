//
//  SearchViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/02.
//

import Foundation
import UIKit
import RealmSwift
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    var mainView = SearchView()
    
    var repository = UserMemoRepository()

    let viewModel = SearchViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
             
        bind()
        
        setUpController()
    }

    private func bind() {
        viewModel.tasks
            .bind(onNext: { [weak self] _ in
                self?.mainView.tableView.reloadData()
            })
            .disposed(by: disposeBag)

    }
    
    func checkCancel(memo: UserMemo, completionHandler: @escaping () -> ()) {
        let alert = UIAlertController(title: "메모를 제거하시겠습니까??", message: "삭제하시면 다시 되돌릴 수 없습니다!!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .destructive) { _ in
            self.viewModel.deleteMemo(memo: memo)
            self.mainView.tableView.reloadData()
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
}
