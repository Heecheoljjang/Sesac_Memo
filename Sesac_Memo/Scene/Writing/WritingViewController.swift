//
//  WritingViewController.swift
//  Sesac_Memo
//
//  Created by HeecheolYoon on 2022/09/01.
//

import Foundation
import UIKit
import RealmSwift

final class WritingViewController: BaseViewController {
    
    var mainView = WritingView()
    
    var repository = UserMemoRepository()
    
    var currentTask: UserMemo!
    
    var isNew = true
        
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addPanGesture()
                        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mainView.textView.becomeFirstResponder()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let omittingTrueArray = mainView.textView.text.split(separator: "\n", omittingEmptySubsequences: true) //공백 없는 것
        let omittingFalseArray = mainView.textView.text.split(separator: "\n", omittingEmptySubsequences: false)//공백 있는 것
        
        //만약 적힌게 있다면 저장, 없으면 그냥 pop
        //이때 편집인지, 새로 작성한건지도 판단해야함.
        if isNew == true {
            //텍스트뷰에 적힌게 없는지 확인해야함 -> omitting뭐시기로 카운트로 확인
            //새로운 작성일땐 count가 0이 아닌 것만 확인하면됨. 수정일때는 count 0이면 delete해주면되고
            if omittingTrueArray.count != 0 {
                
                var tempTitle:[Substring] = []
                var titleLast:Substring = ""
                //빈 칸이 아닐때까지 확인해서 title 만들기
                for subString in omittingFalseArray {
                    //"\n"인 경우에 ""로 나오기때문에 ""인 경우에는 \n를 추가해주는방식으로 구현해봄
                    if subString == "" {
                        tempTitle.append("\n")
                    } else {
                        tempTitle.append(subString + "\n")
                        titleLast = subString
                        break
                    }
                }
                //title의 마지막 원소 이후부터 textViewSubstringArray의 마지막까지 content로
                //이때도 빈 칸만 있는지 확인해야함.
                //카운트가 1인지만 확인하면될듯
                if omittingTrueArray.count == 1  {
                    //같으면 content는 빈칸으로
                    let title = tempTitle.joined()
                    
                    let task = UserMemo(memoTitle: title, memoContent: "", registerDate: Date())
                    repository.addMemo(memo: task)
                } else {
                    //다르면 content는 titleLast이후부터 마지막까지
                    let title = tempTitle.joined()
                    
                    //여기서도 마찬가지로 새로 변수를 만들어서 ""인 경우에 "\n"을 추가해서 합쳐야할듯
                    let index = omittingFalseArray.firstIndex(of: titleLast)! + 1
                    var tempContent: [Substring] = []
                    for subString in omittingFalseArray[index...] {
                        if subString == "" {
                            tempContent.append("\n")
                        } else {
                            if subString != omittingFalseArray[index...].last {
                                tempContent.append(subString + "\n")
                            } else {
                                tempContent.append(subString)
                            }
                        }
                    }
                    let content = tempContent.joined()
                    
                    let task = UserMemo(memoTitle: title, memoContent: content, registerDate: Date())
                    repository.addMemo(memo: task)
                }
            }
        } else {
            //다 지웠을 경우엔 delete
            if omittingTrueArray.count == 0 {
                repository.deleteMemo(memo: currentTask)
            } else {
                //currentTask랑 비교했을때 다를때만 수정
                var tempTitle:[Substring] = []
                var titleLast:Substring = ""
                
                for subString in omittingFalseArray {
                    if subString == "" {
                        tempTitle.append("\n")
                    } else {
                        tempTitle.append(subString + "\n")
                        titleLast = subString
                        break
                    }
                }
                if omittingTrueArray.count == 1 {
                    let title = tempTitle.joined()
                    let content = ""
                    
                    //다른 경우에만 업데이트
                    if currentTask.memoTitle != title || currentTask.memoContent != content {
                        repository.updateMemo(memo: currentTask, title: title, content: content)
                    }
                } else {
                    let title = tempTitle.joined()
                    
                    let index = omittingFalseArray.firstIndex(of: titleLast)! + 1
                    var tempContent: [Substring] = []
                    for subString in omittingFalseArray[index...] {
                        if subString == "" {
                            tempContent.append("\n")
                        } else {
                            if subString != omittingFalseArray[index...].last {
                                tempContent.append(subString + "\n")
                            } else {
                                tempContent.append(subString)
                            }
                        }
                    }
                    let content = tempContent.joined()
                    
                    //다른 경우에만 업데이트
                    if currentTask.memoTitle != title || currentTask.memoContent != content {
                        repository.updateMemo(memo: currentTask, title: title, content: content)
                    }
                }
            }
        }
    }
    
    func addPanGesture() {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(popWritingView(_:)))
        gesture.edges = .left
        mainView.addGestureRecognizer(gesture)
    }
       
    override func setUpController() {
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(presentActivityController))
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(doneTapped))
        
        navigationItem.rightBarButtonItems = [doneButton, shareButton]
        //navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .systemOrange

    }
    
    override func setUpNavigationBarColor() {
        
        navigationController?.isToolbarHidden = true
        
        switch self.traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            mainView.backgroundColor = .systemBackground
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            appearance.shadowColor = .clear
            
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        case .dark:
            mainView.backgroundColor = .systemBackground
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            appearance.shadowColor = .clear
            
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }
    
    //MARK: - @objc
    @objc private func presentActivityController() {

        let text = mainView.textView.text
        
        let activityController = UIActivityViewController(activityItems: [text ?? ""], applicationActivities: [])
        present(activityController, animated: true)
    }
    
    @objc private func doneTapped() {
        //편집 그만(키보드 내리기)
        mainView.textView.endEditing(true)
    }
    
    @objc private func popWritingView(_ sender: UIScreenEdgePanGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}
