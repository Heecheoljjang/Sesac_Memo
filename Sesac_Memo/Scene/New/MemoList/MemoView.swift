//
//  MemoListView.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/10/22.
//

import UIKit
import SnapKit

final class MemoView: BaseView {
    
    let collectionView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    override func configure() {
        super.configure()
        
        addSubview(collectionView)
    }
    
    override func setUpConstraints() {
        super.setUpConstraints()
        
        collectionView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
