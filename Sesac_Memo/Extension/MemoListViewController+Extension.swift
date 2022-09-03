//
//  MemoListViewController+Extension.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation
import UIKit

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return tasks.filter("isFixed == true").count
        } else {
            return tasks.filter("isFixed == false").count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoListTableViewCell.identifier, for: indexPath) as? MemoListTableViewCell else { return UITableViewCell() }
        
        let fixedTasks = tasks.filter("isFixed == true")
        let notFixedTasks = tasks.filter("isFixed == false")
        
        //날짜 포맷 생각하기
        if indexPath.section == 0 {
            cell.titleLabel.text = fixedTasks[indexPath.row].memoTitle
            cell.bottomLabel.text = fixedTasks[indexPath.row].registerDate.checkDate() + "   " + fixedTasks[indexPath.row].memoContent
            
            print(indexPath)
        } else {
            cell.titleLabel.text = notFixedTasks[indexPath.row].memoTitle
            cell.bottomLabel.text = notFixedTasks[indexPath.row].registerDate.checkDate() + "   " + notFixedTasks[indexPath.row].memoContent
            print(indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "고정된 메모"
        } else {
            return "메모"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }

    //삭제
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let fixedTasks = tasks.filter("isFixed == true")
        let notFixedTasks = tasks.filter("isFixed == false")
        
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            if indexPath.section == 0 {
                self.repository.deleteMemo(memo: fixedTasks[indexPath.row])
            } else {
                self.repository.deleteMemo(memo: notFixedTasks[indexPath.row])
            }
            self.mainView.tableView.reloadData()
        }
        delete.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    //고정
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let fixedTasks = tasks.filter("isFixed == true")
        let notFixedTasks = tasks.filter("isFixed == false")
        
        let fix = UIContextualAction(style: .normal, title: nil) { action, view, completionHandler in
            if indexPath.section == 0 {
                self.repository.updateIsFixed(memo: fixedTasks[indexPath.row])
            } else {
                if fixedTasks.count < 5 {
                    self.repository.updateIsFixed(memo: notFixedTasks[indexPath.row])
                } else {
                    self.showAlert(title: "알림", message: "고정은 최대 5개까지만 가능합니다!")
                }
            }
            self.mainView.tableView.reloadData()
        }
        let image = indexPath.section == 0 ? "pin.slash.fill" : "pin.fill"
        fix.image = UIImage(systemName: image)
        
        return UISwipeActionsConfiguration(actions: [fix])
        
    }
}

extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        let vc = SearchViewController()
        vc.tasks = repository.fetchSearch(keyword: text)
    }
}
