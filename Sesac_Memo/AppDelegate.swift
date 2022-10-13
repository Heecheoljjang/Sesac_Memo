//
//  AppDelegate.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/08/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        aboutRealmMigration()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    
    func aboutRealmMigration() {

        let config = Realm.Configuration(schemaVersion: 6) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                // 컬럼 추가
            }
            if oldSchemaVersion < 2 {
                // 컬럼 삭제
            }
            if oldSchemaVersion < 3 {
                //컬럼 이름 변경 memoTitle -> title
                migration.renameProperty(onType: UserMemo.className(), from: "memoTitle", to: "title")
            }
            if oldSchemaVersion < 4 {
                //summary 컬럼 추가 및 데이터 추가
                migration.enumerateObjects(ofType: UserMemo.className()) { oldObject, newObject in
                    guard let new = newObject, let old = oldObject else { return }
                    new["summary"] = "\(old["title"]) \(old["memoContent"])"
                }
            }
            if oldSchemaVersion < 5 {
                //옵셔널 타입 변경
                migration.enumerateObjects(ofType: UserMemo.className()) { oldObject, newObject in
                    guard let new = newObject, let old = oldObject else { return }
                    new["summary"] = old["summary"] ?? "nil이었던애들"
                }
            }
            if oldSchemaVersion < 6  {
                //타입 변경
                migration.enumerateObjects(ofType: UserMemo.className()) { _ , newObject in
                    guard let new = newObject else { return }
                    new["summary"] = 123
                }
            }
        }
        Realm.Configuration.defaultConfiguration = config
    }
}
