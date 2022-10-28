//
//  PopUpViewModel.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/10/28.
//

import Foundation

final class PopUpViewModel {
    
    private let userDefaults = UserDefaults.standard
    
    func setUserDefaults() {
        userDefaults.set(true, forKey: "isFirst")
    }
}
