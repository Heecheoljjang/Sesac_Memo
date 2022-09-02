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
    @Persisted var memoContent: String?
    @Persisted var registerDate: String
    @Persisted var isFixed: Bool = false
    
    @Persisted(primaryKey: true) var objectId: ObjectId // 시간으로 PK를 정할거기 때문
    
    convenience init(memoTitle: String, memoContent: String?, registerDate: String) {
        self.init()
        self.memoTitle = memoTitle
        self.memoContent = memoContent
        self.registerDate = registerDate
    }
    
}
