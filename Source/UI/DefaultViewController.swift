//
//  File name : DefaultViewController.swift
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
//  Created by Blueshift on 2021/09/07
//

import UIKit

open class DefaultViewController: UIViewController {

    var scrollView:UIScrollView?
    var isBackButton = false
    var isCloseButton = false
    var isNotiButton = false
    var isKeyboardUse = false
    
    //MARK:- Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeUI()
    }
    
    //MARK:- Methods
    open func initializeUI() {
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
        
        if isNotiButton {
            let rightBtn = UIImage(systemName: "bell")?.withRenderingMode(.alwaysOriginal)
            let rightBarButton = UIBarButtonItem(image: rightBtn, style: .plain, target: self, action: #selector(notificationButtonClicked))
            self.navigationItem.rightBarButtonItem = rightBarButton
        }
        
        if isCloseButton {
            let rightBtn = UIImage(systemName: "xmark")?.withRenderingMode(.alwaysOriginal)
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
    
    //MARK:- Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc internal func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc internal func notificationButtonClicked() {
//        let nvc = UINavigationController(rootViewController: PushNotificationViewController())
//        nvc.modalPresentationStyle = .fullScreen
//        present(nvc, animated: true)
    }
    
    @objc internal func closeButtonClicked() {
        dismiss(animated: true)
    }
    
    //MARK:- Keyboard hide & show
    @objc public func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
            return
        }
        
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
