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
    
    let resultVC = SearchViewController()
    
    var resultTasks = PublishSubject<Results<UserMemo>>()
    
    var searchKeyword = BehaviorRelay(value: "")
    
    func fetchMemo() {
        tasks.onNext(repository.fetch())
    }
    
    func fetchIsFixed(isFixed: Bool) -> Results<UserMemo> {
        return repository.fetchFiltered(filter: "isFixed == \(isFixed)")
    }
    
    func fetchFilteredCount(isFixed: Bool) -> Int {
        return repository.fetchFiltered(filter: "isFixed == \(isFixed)").count
    }
    
    func checkFilteredCount(isFixed: Bool, count: Int) -> Bool {
        return fetchFilteredCount(isFixed: isFixed) == count ? true : false
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
        let task = UserMemo(title: "", memoContent: "", registerDate: Date())
        repository.addMemo(memo: task)
        fetchMemo()
    }
    
    func deleteMemo(memo: UserMemo) {
        repository.deleteMemo(memo: memo)
        fetchMemo()
    }
    
    func fetchFirst() -> UserMemo {
        return repository.fetch().first!
    }
    
    func updateIsFixed(memo: UserMemo) {
        repository.updateIsFixed(memo: memo)
        fetchMemo()
    }
    
//    func fetchSearch(keyword: String) {
//        tasks
//    }
    
    func setSearchKeyword(keyword: String) {
        print("keyword: \(keyword)")
        searchKeyword.accept(keyword)
        print("seaerechKeyword: \(searchKeyword.value)")
    }
    
    func numberSetting(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: number) ?? "0"
    }
    
}
