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
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
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
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(self)
            make.bottom.equalTo(bottomLabel.snp.top).offset(12)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(self).offset(-16)
        }
    }
}
