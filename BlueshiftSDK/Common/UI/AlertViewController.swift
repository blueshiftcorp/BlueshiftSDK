//
//  File name : AlertViewController.swift
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
//  Created by Blueshift on 2021/11/26
//

import UIKit

class AlertViewController: UIViewController {

    var msgTitle: String?
    var message: Any!
    var isCancelButton: Bool?
    var confirmed: (() -> Void)?
    
    init(title: String? = nil, message: Any, isCancelButton: Bool? = false, confirmed: (()->Void)? = nil) {
        self.msgTitle = title
        self.message = message
        self.isCancelButton = isCancelButton
        self.confirmed = confirmed
        
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
        setMessageView()
    }
    
    private func setMessageView() {
        let v = UIView()
        let stView = UIStackView()
        let stButtons = UIStackView()
        let lblTitle = UILabel()
        let lblMessage = UILabel()
        let btnCancel = createButton("취소")
        btnCancel.backgroundColor = .gray
        let btnConfirm = createButton("확인")
        if self.msgTitle == "회원탈퇴" { btnConfirm.backgroundColor = .red }
        
        v.layer.cornerRadius = 20
        v.backgroundColor = .white
        
        stView.axis = .vertical
        stView.spacing = 25
        stButtons.axis = .horizontal
        stButtons.distribution = .fillEqually
        stButtons.spacing = 15
        
        lblTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lblTitle.text = msgTitle
        lblTitle.textAlignment = .center
        
        if msgTitle == nil {
            lblMessage.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            lblMessage.textAlignment = .center
        } else {
            lblMessage.font = UIFont.systemFont(ofSize: 13)
        }
        
        if let msg = message as? String {
            lblMessage.text = msg
        } else if let msg = message as? NSAttributedString {
            lblMessage.attributedText = msg
        }
        
        lblMessage.numberOfLines = 0
        lblMessage.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.3)
        
        btnCancel.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        btnConfirm.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
        
        if self.isCancelButton! { stButtons.addArrangedSubview(btnCancel)}
        stButtons.addArrangedSubview(btnConfirm)
        
        if self.msgTitle != nil { stView.addArrangedSubview(lblTitle) }
        stView.addArrangedSubview(lblMessage)
        stView.addArrangedSubview(stButtons)
        v.addSubview(stView)
        v.addSubview(stButtons)
        view.addSubview(v)
        
        v.translatesAutoresizingMaskIntoConstraints = false
        stView.translatesAutoresizingMaskIntoConstraints = false
        stButtons.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            v.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            v.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            v.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stView.topAnchor.constraint(equalTo: v.topAnchor, constant: 30),
            stView.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -25),
            stView.bottomAnchor.constraint(equalTo: stButtons.topAnchor, constant: -30),
            stView.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 25),
            
            stButtons.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -25),
            stButtons.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -30),
            stButtons.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 25),
            stButtons.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func cancelButtonClicked() {
        self.dismiss(animated: false)
    }

    @objc private func confirmButtonClicked() {
        if self.confirmed != nil {
            self.confirmed!()
            self.dismiss(animated: false)
        } else {
            self.dismiss(animated: false)
        }
    }
    
    private func createButton(_ label: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle(label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.backgroundColor = UIColor(named: "blue_main")
        button.titleLabel?.textColor = .white
        return button
    }
}
