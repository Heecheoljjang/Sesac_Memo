//
//  MemoListViewModel.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/10/22.
//

import Foundation
import RealmSwift

final class MemoViewModel {
    
    var tasks: Observable<List<UserMemo>?> = Observable(nil)
    
    let repository = UserMemoRepository()
    
    var title = ""
    
    func fetchMemo() {
//        tasks.value = Array(repository.fetchFolder(title: title)!)
        print("title")
        print(repository.fetchFolder(title: title))
    }
    
    func createMemo() {
        repository.addMemo(memo: UserMemo(title: "test", memoContent: "Hi", registerDate: Date()))
        fetchMemo()
    }
}
