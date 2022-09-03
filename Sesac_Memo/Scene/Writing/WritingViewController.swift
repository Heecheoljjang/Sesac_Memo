//
//  WritingViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation
import UIKit
import RealmSwift

final class WritingViewController: BaseViewController {
    
    var mainView = WritingView()
    
    var repository = UserMemoRepository()
    
    var currentTask: UserMemo!
    
    var isNew = true
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setUpController()
        
        mainView.textView.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //만약 적힌게 있다면 저장, 없으면 그냥 pop
        //이때 편집인지, 새로 작성한건지도 판단해야함.
//        if isNew == true {
//            if mainView.textView.text != "" {
//                let task = UserMemo(memoTitle: "타이틀", memoContent: mainView.textView.text, registerDate: Date())
//                repository.addMemo(memo: task)
//            }
//        } else {
//            //편집인데, 이전과 내용이 같은지 확인해야함
//            let task = UserMemo(memoTitle: <#T##String#>, memoContent: <#T##String#>, registerDate: <#T##Date#>)
//            repository.updateMemo(memo: currentTask, title: <#T##String#>, content: <#T##String#>)
//        }
        if mainView.textView.text != "" {
            let task = UserMemo(memoTitle: "타이틀", memoContent: mainView.textView.text, registerDate: Date())
            repository.addMemo(memo: task)
        }
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

        let text = mainView.textView.text
        
        let activityController = UIActivityViewController(activityItems: [text ?? ""], applicationActivities: [])
        present(activityController, animated: true)
    }
    
    @objc private func doneTapped() {
        //편집 그만(키보드 내리기)
        mainView.textView.endEditing(true)
    }
}
