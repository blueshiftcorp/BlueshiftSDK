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
    
    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 12.0), completion: (() -> Void)? = nil) {
        let toastLabel = UILabelPadding(frame: .zero)
        toastLabel.backgroundColor = .white
        toastLabel.numberOfLines = 0
        toastLabel.lineBreakMode = .byWordWrapping
        toastLabel.textColor = .black
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.setLineSpacing(lineHeightMultiple: 1.2)
        toastLabel.clipsToBounds  =  true
        toastLabel.borderColor = .gray
        toastLabel.borderWidth = 1
        toastLabel.text = message
        toastLabel.sizeToFit()
        self.view.addSubview(toastLabel)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        toastLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        toastLabel.heightAnchor.constraint(equalToConstant: toastLabel.frame.height + 30).isActive = true
        toastLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 30).isActive = true
        toastLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -30).isActive = true
        
        UIView.animate(withDuration: 1.0, delay: 3, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            if completion != nil { completion!() }
        })
    }
}
