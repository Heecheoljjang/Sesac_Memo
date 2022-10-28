//
//  SearchViewModel.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/10/27.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

final class SearchViewModel {
    
    var tasks = BehaviorSubject<Results<UserMemo>?>(value: nil)
    
    let repository = UserMemoRepository()
    
    func deleteMemo(memo: UserMemo) {
        repository.deleteMemo(memo: memo)
    }
    
    func fetchSearch(keyword: String) {
        tasks.onNext(repository.fetchSearch(keyword: keyword))
        print(try! tasks.value())
    }
    
    func fetchCurrentCount() -> Int {
        return try! tasks.value()?.count ?? 0
    }
    
    func fetchMemoCount() -> Int {
        return repository.fetch().count
    }
    
    func fetchMemo() -> Results<UserMemo> {
        return repository.fetch()
    }
    
    func fetchTask() -> Results<UserMemo> {
        return try! tasks.value() ?? fetchMemo()
    }
    
    func updateIsFixed(memo: UserMemo) {
        repository.updateIsFixed(memo: memo)
//        tasks.onNext(fetchMemo())
    }
}
