//
//  PopUpView.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation
import UIKit

import SnapKit

final class PopUpView: BaseView {
    
    let outerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let popUpTextView: UITextView = {
        let view = UITextView()
        view.text = "처음 오셨군요!\n환영합니다 :)\n\n당신만의 메모를 작성하고 관리해보세요!"
        view.font = .systemFont(ofSize: 22, weight: .bold)
        view.backgroundColor = .clear
        
        return view
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setUpConstraints()
    }
    
    override func configure() {
        [outerView, popUpTextView, okButton].forEach {
            self.addSubview($0)
        }
        backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    override func setUpConstraints() {
        outerView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.equalTo(self.snp.width).multipliedBy(0.65)
        }
        
        popUpTextView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(outerView).inset(20)
            make.bottom.equalTo(okButton.snp.top).offset(-20)
            make.height.equalTo(outerView.snp.width).multipliedBy(0.56)
        }
        
        okButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(outerView).inset(20)
            make.height.equalTo(outerView.snp.width).multipliedBy(0.2)
        }
    }
}
