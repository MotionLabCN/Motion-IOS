//
//  WebVC.swift
//  GitHubAuthExcample
//
//  Created by 梁泽 on 2021/9/27.
//

import UIKit
import WebKit

class AuthWkWebVC: UIViewController {
    let webView = WKWebView()
    let url: URL
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = view.bounds
        
        self.view.addSubview(webView)
        
        webView.load(URLRequest(url: url))
        
        webView.navigationDelegate = self
    }
}


extension AuthWkWebVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("WebVC url =" + navigationAction.request.url!.absoluteString)
        /*
         https://github.com/login/oauth/authorize?client_id=&scope=usering,dear
         https://github.com/login?client_id=&return_to=%2Flogin%2Foauth%2Fauthorize%3Fclient_id%3D%26scope%3Dusering%252Cdear
         2. 登录
         https://github.com/session
         https://github.com/login/oauth/authorize?client_id=e15511b567cac1de8681&scope=
         https://lightapp-1c3d5.firebaseapp.com/__/auth/handler?code=ad493ea06585c4565907
         
         3.拿到code 去获取token 文档： https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps
         */
        decisionHandler(.allow)
    }
}
