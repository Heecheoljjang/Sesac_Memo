//
//  SearchView.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/02.
//

import Foundation
import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let tableView: UITableView = {
        let view = UITableView(frame: CGRect.zero, style: .insetGrouped)
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        backgroundColor = .systemGray6
    }
    
    override func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
