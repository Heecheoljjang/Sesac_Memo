//
//  PopUpViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//
import UIKit
import RxSwift
import RxCocoa

final class PopUpViewController: BaseViewController {
    
    private var mainView = PopUpView()
    
    private let viewModel = PopUpViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
    }
    
    private func bind() {
        mainView.okButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.dismissView()
            })
            .disposed(by: disposeBag)
    }
    
    override func configure() {
        super.configure()
        
        viewModel.setUserDefaults()

    }

    private func dismissView() {
        self.dismiss(animated: true)
    }
}
