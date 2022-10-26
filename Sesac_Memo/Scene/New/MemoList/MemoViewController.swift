//
//  MemoListViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/10/22.
//

import UIKit
import RealmSwift

final class MemoViewController: BaseViewController {
    
    private var mainView = MemoView()
    
    var viewModel = MemoViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, UserMemo>!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(viewModel.title)
        print(viewModel.repository.fetchFolder(title: viewModel.title))
        bind()
        
        configureHierarchy()
        configureDataSource()
        
        viewModel.fetchMemo()
    }
    
    override func configure() {
        super.configure()
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createMemo))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    private func bind() {
        viewModel.tasks.bind { [weak self] task in
            //스냅샷
            var snapshot = NSDiffableDataSourceSnapshot<Int, UserMemo>()
            snapshot.appendSections([0])
//            snapshot.appendItems(Array(task))
            self?.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    @objc private func createMemo() {
        viewModel.createMemo()
    }
}

extension MemoViewController {
    private func configureHierarchy() {
        mainView.collectionView.collectionViewLayout = createLayout()
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, UserMemo> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.secondaryText = itemIdentifier.memoContent
            
            cell.contentConfiguration = content
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: mainView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
}
