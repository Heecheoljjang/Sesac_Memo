//
//  FolderListViewModel.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/10/22.
//

import Foundation
import RealmSwift

final class FolderListViewModel {
    
    var tasks: Observable<Results<MemoFolder>?> = Observable(nil)
        
    let repository = UserMemoRepository()
    
    func fetchTasks() {
        tasks.value = repository.fetchFolders()
    }
    
    func appendFolder(title: String) {
        repository.addFolder(folder: MemoFolder(title: title))
        fetchTasks()
    }
}
