//
// File name : UIViewController+Extension.swift
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



public extension UIViewController {
    
    enum BSToastAnimationType {
        case fadeInOut
        case fromBottom
    }
    
    func showToast(message : String,
                   animationType: BSToastAnimationType? = nil,
                   delay: TimeInterval? = nil,
                   font: UIFont? = nil,
                   completion: (() -> Void)? = nil) {
        
        let bottomMargin: CGFloat = 0
        
        let containerView = UIView()
        let lblToast = UILabel()
        
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds  =  true
        
        lblToast.numberOfLines = 0
        lblToast.lineBreakMode = .byWordWrapping
        lblToast.textColor = .white
        lblToast.font = font ?? UIFont.systemFont(ofSize: 15)
        lblToast.textAlignment = .center
        lblToast.setLineSpacing(lineHeightMultiple: 1.2)
        
        lblToast.borderColor = .gray
        lblToast.text = message
        containerView.addSubview(lblToast)
        view.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        lblToast.translatesAutoresizingMaskIntoConstraints = false
                
        let bottomConstraint = NSLayoutConstraint(item: containerView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self.view.safeAreaLayoutGuide,
                                              attribute: .bottom,
                                              multiplier: 1,
                                              constant: 0)
        
        NSLayoutConstraint.activate([
            
            lblToast.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            lblToast.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            lblToast.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            lblToast.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomConstraint
        ])
        
        switch animationType {
        case .fromBottom:
            bottomConstraint.constant = 100
        default:
            bottomConstraint.constant = -bottomMargin
            containerView.alpha = 0
        }
        view.layoutIfNeeded()
        
        UIView.animateKeyframes(withDuration: 4,
                                delay: 0,
                                options: [],
                                animations:  {
            
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.05) {
                switch animationType {
                case .fromBottom:
                    bottomConstraint.constant = -bottomMargin
                    self.view.layoutIfNeeded()
                default:
                    containerView.alpha = 1.0
                }
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.9,
                               relativeDuration: 0.05) {
                switch animationType {
                case .fromBottom:
                    bottomConstraint.constant = 100
                    self.view.layoutIfNeeded()
                default:
                    containerView.alpha = 0.0
                }
            }
        }, completion: {_ in
            containerView.removeFromSuperview()
            if completion != nil { completion!() }
        })
    }
}
