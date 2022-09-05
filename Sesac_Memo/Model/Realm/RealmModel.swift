//
//  RealmModel.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/08/31.
//

import Foundation
import RealmSwift

final class UserMemo: Object {
    
    @Persisted var memoTitle: String
    @Persisted var memoContent: String
    @Persisted var registerDate = Date()
    @Persisted var isFixed: Bool = false
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(memoTitle: String, memoContent: String, registerDate: Date) {
        self.init()
        self.memoTitle = memoTitle
        self.memoContent = memoContent
        self.registerDate = registerDate
    }
    
}