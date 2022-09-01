//
//  WritingViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation
import UIKit

final class WritingViewController: BaseViewController {
    
    var mainView = WritingView()
    
    var repository = UserMemoRepository()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //키보드띄우기
        mainView.textView.text = "123123213213213213213213213124321r231r23rwef2wc2f32f321fd32"
        
        setUpController()
    }
        
    override func setUpController() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(presentActivityController))
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneTapped))
        
        navigationItem.rightBarButtonItems = [doneButton, shareButton]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemOrange
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

    }
    
    //MARK: - @objc
    @objc private func presentActivityController() {
        
    }
    
    @objc private func doneTapped() {
        
        let task = UserMemo(memoTitle: "타이틀", memoContent: mainView.textView.text, registerDate: Date())
        
        repository.addMemo(memo: task)
        print(task)
    }
}
