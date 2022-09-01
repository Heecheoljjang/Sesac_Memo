//
//  WritingView.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/02.
//

import Foundation
import UIKit
import SnapKit

final class WritingView: BaseView {
    
    let outerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16, weight: .semibold)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setUpConstraints()
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
