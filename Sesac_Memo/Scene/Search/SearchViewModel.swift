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
    
    var tasks = PublishSubject<Results<UserMemo>>()
    
    let repository = UserMemoRepository()
    
    func deleteMemo(memo: UserMemo) {
        repository.deleteMemo(memo: memo)
    }
    
    func fetchSearch(keyword: String) {
        tasks.onNext(repository.fetchSearch(keyword: keyword))
    }
    
    func fetchMemoCount() -> Int {
        return repository.fetch().count
    }
}
