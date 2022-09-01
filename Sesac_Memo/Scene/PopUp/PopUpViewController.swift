//
//  PopUpViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//
import UIKit

final class PopUpViewController: BaseViewController {
    
    private var mainView = PopUpView()
    
    private let userDefaults = UserDefaults.standard
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        setUpController()
        
    }
    
    override func configure() {
        super.configure()
        
        userDefaults.set(true, forKey: "isFirst")

    }
    
    override func setUpController() {
        super.setUpController()
        
        mainView.okButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
    }
    
    //MARK: - @objc
    @objc func dismissView() {
        self.dismiss(animated: true)
    }
}
