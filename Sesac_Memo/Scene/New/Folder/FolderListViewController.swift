//
//  FolderListViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/10/18.
//

import UIKit
import RealmSwift

final class FolderListViewController: BaseViewController {
        
    private var mainView = FolderListView()
    
    private var viewModel = FolderListViewModel()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, MemoFolder>!
        
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        configureHierarchy()
        configureDataSource()
        
        viewModel.fetchTasks()
    }
    
    override func configure() {
        super.configure()
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createFolder))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func bind() {
        viewModel.tasks?.bind { [weak self] task in
            //스냅샷
            guard let task = task else { return }
            var snapshot = NSDiffableDataSourceSnapshot<Int, MemoFolder>()
            snapshot.appendSections([0])
            snapshot.appendItems(Array(task))
            self?.dataSource.apply(snapshot, animatingDifferences: false)
         }
    }
    
    @objc private func createFolder() {
        guard let text = mainView.titleTextField.text else { return }
        viewModel.appendFolder(title: text) //스냅샷 수정은 위에 작성
    }
}

extension FolderListViewController {
    
    private func configureHierarchy() {
        mainView.collectionView.collectionViewLayout = createLayout()
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MemoFolder> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            content.image = UIImage(systemName: "folder")
            
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
