//
//  PopUpViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//
import UIKit

final class PopUpViewController: BaseViewController {
    
    private var mainView = PopUpView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
