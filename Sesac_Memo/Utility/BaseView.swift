//
//  BaseView.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/08/31.
//

import Foundation
import UIKit

class BaseView: UIView {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setUpConstraints()
    }
    
    //사용하지 않는 코드이므로
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {}
    
    func setUpConstraints() {}
    
}
