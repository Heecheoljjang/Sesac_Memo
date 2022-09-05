//
//  MemoRepository.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/08/31.
//

import Foundation
import RealmSwift
import UIKit

protocol UserMemoRepositoryType {
    
    func fetch() -> Results<UserMemo> //메모
    func fetchSearch(keyword: String) -> Results<UserMemo> //검색결과
    func addMemo(memo: UserMemo) //데이터 추가
    func updateMemo(memo: UserMemo, title: String, content: String) // 데이터 수정(고정 / 메모 수정)
    func updateIsFixed(memo: UserMemo)
    func deleteMemo(memo: UserMemo) // 데이터 삭제
}

final class UserMemoRepository: UserMemoRepositoryType {

    //인스턴스 생성
    let localRealm = try! Realm()
    
    func fetch() -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self).sorted(byKeyPath: "registerDate", ascending: false)
    }
    
    func fetchSearch(keyword: String) -> Results<UserMemo> {
        return localRealm.objects(UserMemo.self).filter("memoContent CONTAINS[c] '\(keyword)' OR memoTitle CONTAINS[c] '\(keyword)'").sorted(byKeyPath: "registerDate", ascending: false)
    }
    
    func addMemo(memo: UserMemo) {
        do {
            try localRealm.write {
                localRealm.add(memo)
                print(localRealm.configuration.fileURL!)
            }
        } catch RepositoryError.addFailed {
            print("데이터 저장 실패")
        } catch {
            print("알 수 없는 오류")
        }
    }
    
    func updateMemo(memo: UserMemo, title: String, content: String) {

        do {
            try localRealm.write {
                memo.memoTitle = title
                memo.memoContent = content
                memo.registerDate = Date()
            }
        } catch RepositoryError.updateFailed {
            print("데이터 수정 실패")
        } catch {
            print("알 수 없는 오류")
        }
    }
    
    func updateIsFixed(memo: UserMemo) {
        do {
            try localRealm.write {
                memo.isFixed = !memo.isFixed
            }
        } catch RepositoryError.updateFailed {
            print("데이터 수정 실패")
        } catch {
            print("알 수 없는 오류")
        }
    }

    func deleteMemo(memo: UserMemo) {
        do {
            try localRealm.write {
                localRealm.delete(memo)
            }
        } catch RepositoryError.deleteFailed {
            print("삭제 실패")
        } catch {
            print("알 수 없는 오류")
        }
    }
}
