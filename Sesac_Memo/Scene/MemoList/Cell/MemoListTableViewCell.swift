//
//  MemoListTableViewCell.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation
import UIKit
import SnapKit

final class MemoListTableViewCell: BaseTableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: MemoListTableViewCell.identifier)
        
        configure()
        
        setUpContraints()
        
    }
    
    override func configure() {
        super.configure()
        
        [titleLabel, bottomLabel].forEach {
            self.addSubview($0)
        }
    }
    
    override func setUpContraints() {
        super.setUpContraints()
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(28)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
