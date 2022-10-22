//
//  FolderListView.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/10/18.
//

import UIKit
import SnapKit

final class FolderListView: BaseView {
    
    let collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)

        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        //view.register(FolderListTableViewCell.self, forCellReuseIdentifier: FolderListTableViewCell.identifier)

        return view
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configure() {
        super.configure()
        
        [collectionView, titleTextField].forEach {
            addSubview($0)
        }
        
        addSubview(collectionView)
        backgroundColor = .white
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
