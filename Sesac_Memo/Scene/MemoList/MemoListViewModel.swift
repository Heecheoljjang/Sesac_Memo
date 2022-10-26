//
//  MemoListViewModel.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/10/27.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

final class MemoListViewModel {
    
    let repository = UserMemoRepository()
    
    var tasks = PublishSubject<Results<UserMemo>>()
    
    let userDefaults = UserDefaults.standard
    
    func fetchMemo() {
        tasks.onNext(repository.fetch())
    }
    
    func fetchFiltered(filter: String) -> Results<UserMemo> {
        return repository.fetchFiltered(filter: filter)
    }
    
    func fetchFilteredCount() -> Int {
        
    }
    
    func checkFirst() -> Bool {
        return userDefaults.bool(forKey: "isFirst") == false ? true : false
    }
    
    func emptyDelete() {
        let latestTask = repository.fetch().first
        if latestTask?.title.trimmingCharacters(in: .whitespacesAndNewlines) == "" && latestTask?.memoContent.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            repository.deleteMemo(memo: latestTask!)
            fetchMemo()
        }
    }
    
    func addMemo() {
        let task = UserMemo(memoTitle: "", memoContent: "", registerDate: Date())
        repository.addMemo(memo: task)
    }
    
    func fetchFirst() -> UserMemo {
        return repository.fetch().first!
    }
}
