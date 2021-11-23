//
//  File name : BSViewController.swift
//
//  Copyright (c) 2009-2021 Blueshift Corporation. All right reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created by Blueshift on 2021/11/23
//

import UIKit

class BSViewController: UIViewController {

    enum BSVCOption {
        case backButton
        case closeButton
        case keyboard
    }
    
    internal var scrollView:UIScrollView?
    private var isBackButton = false
    private var isCloseButton = false
    private var isKeyboardUse = false
    
    /// BSViewController 초기화 옵션
    ///
    /// 네비게이션 버튼, 스크롤뷰 유무에 대한 옵션 설정
    /// backButton : 좌측상단 네비게이션 뒤로가기 버튼 표시, popViewController
    /// closeButton : 우측상단 네비게이션 X 버튼 표시, ModalViewController 닫기버튼으로 사용
    /// keyboard: UITextField 사용 시 키보드 표시로 인하여 하단 UI가 가려질 경우 사용
    ///
    /// - parameters :
    ///     - options: [BSVCOption]
    ///     - scrollView: UIScrollView
    ///
    init(_ options: [BSVCOption], scrollView: UIScrollView? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        for option in options {
            switch option {
            case .backButton:
                self.isBackButton = true
            case .closeButton:
                self.isCloseButton = true
            case .keyboard:
                self.isKeyboardUse = true
            }
        }
        
        self.scrollView = scrollView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
    }
    
    //MARK: - Methods
    internal func initializeUI() {
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        if isBackButton {
            let leftBtn = UIImage(systemName: "arrow.backward")?.withRenderingMode(.alwaysOriginal)
            let leftBarButton = UIBarButtonItem(image: leftBtn, style: .plain, target: self, action: #selector(backButtonClicked))
            self.navigationItem.leftBarButtonItem = leftBarButton
        }
        
        if isCloseButton {
            let rightBtn = UIImage(named: "ic_x")?.withRenderingMode(.alwaysOriginal)
            let rightBarButton = UIBarButtonItem(image: rightBtn, style: .plain, target: self, action: #selector(closeButtonClicked))
            self.navigationItem.rightBarButtonItem = rightBarButton
        }
        
        if isKeyboardUse {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
    }
    
    //MARK: - Actions
    @objc internal func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc internal func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc internal func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    //MARK: - Keyboard hide & show
    @objc public func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        if isKeyboardUse {
            if scrollView != nil {
                let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
                scrollView!.contentInset = contentInsets
                scrollView!.scrollIndicatorInsets = contentInsets
            } else {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        if scrollView != nil {
            scrollView!.contentInset = contentInsets
            scrollView!.scrollIndicatorInsets = contentInsets
        }
        
        if isKeyboardUse {
            if scrollView != nil {
                
            } else {
                if self.view.frame.origin.y != 0 {
                    self.view.frame.origin.y = 0
                }
            }
        }
    }
}

