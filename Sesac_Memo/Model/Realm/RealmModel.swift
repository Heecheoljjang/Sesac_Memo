//
//  RealmModel.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/08/31.
//

import Foundation
import RealmSwift

final class UserMemo: Object {
    
    @Persisted var title: String
    @Persisted var memoContent: String
    @Persisted var summary: Int
    @Persisted var registerDate = Date()
    @Persisted var isFixed: Bool = false
//    @Persisted(originProperty: "title") var folderTitle: LinkingObjects<MemoFolder>
        
    @Persisted(primaryKey: true) var objectId: ObjectId

    convenience init(memoTitle: String, memoContent: String, registerDate: Date) {
        self.init()
        self.title = memoTitle
        self.memoContent = memoContent
        self.registerDate = registerDate
    }
}

final class MemoFolder: Object {
    
    @Persisted var title: String
    @Persisted var memos: List<UserMemo>
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
