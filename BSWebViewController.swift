//
//  File name : BSWebViewController.swift
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
import WebKit

@objc protocol BSWebViewControllerDelegate {
    @objc optional func dataReceivedFromServer(_ data: Data)
    @objc optional func callFromServerWithoutData()
}

class BSWebViewController: BSViewController {
    
    var webView: WKWebView?
    var url: String!
    var params = [String: String]()
    var router: APIConfiguration?
    var delegate: BSViewControllerDelegate?
    var activityIndicator = UIActivityIndicatorView()
          
    override func initializeUI() {
        super.initializeUI()
        
        guard BSUtil.Connectivity.isConnected else {
            showRefreshButton()
            return
        }
        
//        guard let link = router?.path, link.count > 0 else {
//            Util.Common.setupCommonCode {
//                self.setWebView()
//            }
//            return
//        }
        
        setWebView()
    }
    
    override func backButtonClicked() {
        if webView != nil, webView!.canGoBack {
            webView!.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func setWebView() {
        webView = WKWebView(frame: self.view.frame, configuration: webViewConfig)
        webView!.allowsLinkPreview = false
        webView!.navigationDelegate = self
        self.view.addSubview(webView!)
        
        if router == nil {
            let request = URLRequest(url: URL(string: self.url)!)
            webView!.load(request)
        } else {
            do {
                webView!.load(try router!.asURLRequest())
            } catch {
                NSLog("웹뷰 로드 중 오류가 발생했습니다: \(error)")
            }
        }
    }
    
    private var webViewConfig: WKWebViewConfiguration {
        let source: String = "var meta = document.createElement('meta');"
                           + "meta.name = 'viewport';"
                           + "meta.content = 'width=device-width, initial-scale=0.8, maximum-scale=1.0, user-scalable=no';"
                           + "var head = document.getElementsByTagName('head')[0];"
                           + "head.appendChild(meta);"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let userContentController = WKUserContentController()
        userContentController.addUserScript(script)
        userContentController.add(self, name: "dataToWebView")
        
        let conf = WKWebViewConfiguration()
        conf.userContentController = userContentController
        
        return conf
    }
    
    private func showRefreshButton() {
        let lblAlert = UILabel()
        lblAlert.text = "네트워크 연결이 원활하지 않습니다.\n잠시 후 다시 시도해 주십시오."
        lblAlert.font = UIFont.systemFont(ofSize: 15)
        lblAlert.numberOfLines = 0
        lblAlert.textAlignment = .center
        lblAlert.setLineSpacing()
        
        let btnReload = UIButton()
        btnReload.setTitle("새로고침", for: .normal)
        btnReload.backgroundColor = .blueMain
        btnReload.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btnReload.layer.cornerRadius = 10
        btnReload.addTarget(self, action: #selector(reloadButtonClicked), for: .touchUpInside)

        self.view.addSubview(lblAlert)
        self.view.addSubview(btnReload)
        
        lblAlert.translatesAutoresizingMaskIntoConstraints = false
        btnReload.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lblAlert.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lblAlert.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50),
            btnReload.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            btnReload.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30),
            btnReload.widthAnchor.constraint(equalToConstant: 100),
            btnReload.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func reloadButtonClicked() {
        for v in self.view.subviews {
            v.removeFromSuperview()
        }
        
        initializeUI()
    }
}

//MARK: - WKScriptMessageHander
extension BSWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        switch message.name {
        case "dataToWebView":
            guard let dic = message.body as? [String: AnyObject] else {
                delegate?.callFromServerWithoutData?()
                return }
            print("JavaScript로 전달받은 데이터입니다 : \(dic)")
            
            do {
                let data = try JSONSerialization.data(withJSONObject: dic, options: [])
                delegate?.dataReceivedFromServer?(data)
            } catch {
                let vc = AlertViewController(message: ICError.Registeration.realNameAuth.localizedDescription)
                self.present(vc, animated: false)
                
                print(error.localizedDescription)
            }
        default: break
        }
    }
}

extension BSWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: view.frame.midX - 25, y: view.frame.midY - 25 , width: 50, height: 50)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.removeFromSuperview()
    }
}
