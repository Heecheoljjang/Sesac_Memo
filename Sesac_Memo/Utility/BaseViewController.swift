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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpNavigationBarColor()
        
    }
    
    func configure() {}
    
    func setUpController() {}

    func setUpNavigationBarColor() {}
}
