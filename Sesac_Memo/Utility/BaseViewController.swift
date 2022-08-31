//
//  BaseViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/08/31.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setUpController()
    }
    
    func configure() {}
    
    func setUpController() {}
}
