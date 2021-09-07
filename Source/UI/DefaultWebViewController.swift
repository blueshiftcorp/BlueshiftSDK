//
// File name : WebViewController.swift
// Project name: iCareMe, iCareU 앱 개발
// XCode Project name : iCareMe

// Copyright (c) 2021 iChrogene, Inc. All right reserved.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Created by James, Blueshift Corporation on 2021/08/20
// Website : www.blueshift.co.kr
// Email : admin@blueshift.co.kr
//

import UIKit
import WebKit

open class DefaultWebViewController: DefaultViewController {
    
    var url: String!
      
    open override func initializeUI() {
        guard Util.Connectivity.isConnected else {
            showRefreshButton()
            return }
        
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
