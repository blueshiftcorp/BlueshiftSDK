//
// File name : UIViewController+Extension.swift
// Project name: iCareMe, iCareU 앱 개발
// XCode Project name : iCareMe

// Copyright (c) 2021 iChrogene, Inc. All right reserved.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Created by James, Blueshift Corporation on 2021/08/18
// Website : www.blueshift.co.kr
// Email : admin@blueshift.co.kr
//

import UIKit

extension UIViewController {
    
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
