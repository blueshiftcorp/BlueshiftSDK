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

/// BSViewController 초기화 옵션
///
/// ViewController 초기화에서 backButton, closeButton, keyboard 사용여부를 선택하여야합니다.
/// 해당 옵션을 선택하기 위해서는 BSViewController를 상속받은 Class에서 BSViewControllerConfiguration Protocol의 options를 리턴해야합니다.
///
public protocol BSViewControllerConfiguration {
    func options() -> [BSVCOption]
}

public enum BSVCOption {
    case backButton
    case closeButton
    case keyboard
}

/// UIViewController 기본값 제공 BSViewController
///
/// 앱 전체에 일반적으로 사용되는 기능 및 설정값을 제공하는 Base ViewController입니다.
/// 옵션을 설정하기 위해서는 BSViewControllerConfiguration protocol을 implementation 해야합니다.
///
/// - Variables:
///     - emptyLabel
///     - isRefresing
///     - isLastRow
///     - startRowId
///     - requestRowCnt
///     - cellItems
///
/// - Usage:
/// ```
/// class TestViewController: BSViewController,
///                           BaseViewControllerConfiguration {
///
/// ...
///
///     override options() -> [BSVCOption] {
///         return [.backButton, .closeButton]
///     }
/// }
/// ```
open class BSViewController: UIViewController {
    
    internal var scrollView:UIScrollView?
    private var isBackButton = false
    private var isCloseButton = false
    private var isKeyboardUse = false
    
    //MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        setOptions()
        initializeUI()
    }
    
    //MARK: - Methods
    internal func setOptions() {
        guard let options = options() else { return }
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
    }
    
    public func initializeUI() {
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
    
    open func options() -> [BSVCOption]? { return nil }
    
    //MARK: - Actions
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc public func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc public func closeButtonClicked() {
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

