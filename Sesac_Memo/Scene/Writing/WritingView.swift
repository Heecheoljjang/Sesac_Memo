//
//  WritingView.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/02.
//

import Foundation
import UIKit
import SnapKit
import IQKeyboardManagerSwift

final class WritingView: BaseView {
    
    let outerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 17, weight: .regular)
        view.tintColor = .systemOrange
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setUpConstraints()
        
        //IQKeyboardManager.shared.enable = true
    }
    
    override func configure() {
        super.configure()
        
        [outerView, textView].forEach {
            self.addSubview($0)
        }

    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        
        outerView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        textView.snp.makeConstraints { make in
            make.edges.equalTo(outerView).inset(20)
            
        }
    }
}
