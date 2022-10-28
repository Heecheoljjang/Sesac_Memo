//
//  WritingViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//
import UIKit
import RealmSwift
import IQKeyboardManagerSwift
import RxSwift

final class WritingViewController: BaseViewController {
    
    var mainView = WritingView()
    
    let viewModel = WritingViewModel()
    
    var currentTask: UserMemo!
    
    var isNew = true
    
    let disposeBag = DisposeBag()
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        bind()
        
        addPanGesture()
                        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    private func bind() {

        mainView.textView.rx.text.orEmpty
            .share() //MARK: share
            .map { self.viewModel.textSplit(text: $0, omitting: true) }
            .subscribe(onNext: { [weak self] value in
                self?.viewModel.omittingTrueArray = value
            })
            .disposed(by: disposeBag)
        
        mainView.textView.rx.text.orEmpty
            .share()//MARK: share
            .map { self.viewModel.textSplit(text: $0, omitting: false) }
            .subscribe(onNext: { [weak self] value in
                self?.viewModel.omittingFalseArray = value
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.checkStatus(isNew: isNew) {
            mainView.textView.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        //만약 적힌게 있다면 저장, 없으면 그냥 pop
        //이때 편집인지, 새로 작성한건지도 판단해야함.
        if viewModel.checkStatus(isNew: isNew) {
            //텍스트뷰에 적힌게 없는지 확인해야함 -> omitting뭐시기로 카운트로 확인
            //새로운 작성일땐 count가 0이 아닌 것만 확인하면됨. 수정일때는 count 0이면 delete해주면되고
            if viewModel.checkCountZero(array: viewModel.omittingTrueArray) {
                
                viewModel.checkNewMemo(currentTask: currentTask)
                
            }
        } else {
            
            viewModel.checkEditMemo(currentTask: currentTask)
        }
    }
    
    func addPanGesture() {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(popWritingView(_:)))
        gesture.edges = .left
        mainView.addGestureRecognizer(gesture)
    }
       
    override func setUpController() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(presentActivityController))
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneTapped))
        
        navigationItem.rightBarButtonItems = [doneButton, shareButton]
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .systemOrange

    }
    
    override func setUpNavigationBarColor() {
        
        navigationController?.isToolbarHidden = true
        
        switch self.traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            mainView.backgroundColor = .systemBackground
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            appearance.shadowColor = .clear
            
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        case .dark:
            mainView.backgroundColor = .systemBackground
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            appearance.shadowColor = .clear
            
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
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
    
    @objc private func popWritingView(_ sender: UIScreenEdgePanGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}
