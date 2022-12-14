//
//  MemoListView.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation
import UIKit
import SnapKit

final class MemoListView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .insetGrouped)
        view.register(MemoListTableViewCell.self, forCellReuseIdentifier: MemoListTableViewCell.identifier)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.keyboardDismissMode = .onDrag
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
        setUpConstraints()
    }
    
    override func configure() {
        [tableView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
