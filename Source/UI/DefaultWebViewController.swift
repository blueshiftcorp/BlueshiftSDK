//
// File name : WebViewController.swift
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
import WebKit

open class DefaultWebViewController: DefaultViewController {
    
    var url: String!
      
    open override func initializeUI() {
//        guard Util.Connectivity.isConnected else {
//            showRefreshButton()
//            return }
        
        setWebView()
    }
    
    private func setWebView() {
        let webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)
        
        let urlRequest = URLRequest(url: URL(string: self.url)!)
        webView.load(urlRequest)
    }
    
    private func showRefreshButton() {
        let btnComment = UIButton()
        btnComment.addTarget(self, action: #selector(reloadButtonClicked), for: .touchUpInside)
        btnComment.titleLabel?.lineBreakMode = .byWordWrapping
        btnComment.titleLabel?.text = "네트워크 연결이 원활하지 않습니다.\n잠시 후 다시 시도해 주십시오.\\n\n새로고침"

        self.view.addSubview(btnComment)
        
        btnComment.translatesAutoresizingMaskIntoConstraints = false
        btnComment.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnComment.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    
    @objc private func reloadButtonClicked() {
        for v in self.view.subviews {
            v.removeFromSuperview()
        }
        
        initializeUI()
    }
}
