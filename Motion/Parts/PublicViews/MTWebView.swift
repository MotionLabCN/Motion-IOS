//
//  MTWebView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/22.
//

import WebKit
import SwiftUI
import MotionComponents


struct MTWebView: View {
    let urlString: String
    @StateObject var webvm = MTWebViewModel()
    //    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0.0) {
            ProgressView(value: webvm.estimatedProgress, total: 1)
                .mtProgressLine(height: webvm.estimatedProgress < 0.8 ? 3 : 0)
                .opacity(webvm.estimatedProgress < 0.8 ? 1 : 0)
                .mtAnimation(.default.delay(0.2))
            
            MTWebViewRepresentable(webView: webvm.webView)
                .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarTitle(webvm.title ?? "loading...")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            webvm.loadUrl(urlString: urlString)
            TabbarState.shared.isShowTabbar = false
        }
        .onDisappear {
            withAnimation {
                TabbarState.shared.isShowTabbar = true
            }
        }
    }
}




//MARK: - 视图提供者
struct MTWebViewRepresentable : UIViewRepresentable {
    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) { }
    
}

class MTWebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // TODO
        //        decisionHandler(.allow)
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        let urlScheme = url.scheme ?? ""
        //hellow
        let urlStr = url.absoluteString
        
        // 此处拦截支付宝支付
        if urlScheme == "alipay" || urlScheme == "alipays" {
// 此处是为处理支付宝支付链接的 scheme（解决支付完成后无法返回app的问题）
            alipayToWebView(webView, navigationAction: navigationAction, url: url, decisionHandler: decisionHandler)
 
        } else {
            
            var request = navigationAction.request
            let payUrl = request.url!
            // 此处拦截微信支付
            if urlStr.contains("wx.tenpay.com") && request.value(forHTTPHeaderField: "Referer") != "pay.dassoft.cn://" {
                decisionHandler(WKNavigationActionPolicy.cancel)
                request.setValue("pay.dassoft.cn://", forHTTPHeaderField: "Referer")
                webView.load(request)
                
            } else {
                
                if urlScheme == "weixin" {
                    if payUrl.host == "wap" {
                        if payUrl.relativePath == "/pay" {
                            if UIApplication.shared.canOpenURL(payUrl) {
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(payUrl, options: [:], completionHandler: nil)
                                } else {
                                    UIApplication.shared.openURL(payUrl)
                                }
                            }
                        }
                    }
                }
                decisionHandler(WKNavigationActionPolicy.allow)
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        // TODO
        decisionHandler(.allow)
    }
    
    // MARK: 跳转到支付宝
    func alipayToWebView(_ webView: WKWebView,
                         navigationAction: WKNavigationAction, url: URL,
                         decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let aliurl = url.absoluteString + "&fromAppUrlScheme=motionNative"
        let aliPayUrl = URL(string: aliurl)!
        
        if UIApplication.shared.canOpenURL(aliPayUrl) {
            UIApplication.shared.open(aliPayUrl, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
            return
        } else {
            webView.load(navigationAction.request)
            //                    self.webvm.loadUrl(urlString: navigationAction.request)
            decisionHandler(.allow)
        }
    }
}

class MTWebViewModel: NSObject, ObservableObject {
    let webView: WKWebView
    
    private let navigationDelegate: MTWebViewNavigationDelegate
    
    override init() {
        //        self.urlString = urlString
        let configuration = WKWebViewConfiguration()
        //        configuration.websiteDataStore = .nonPersistent()
        webView = WKWebView(frame: .zero, configuration: configuration)
        navigationDelegate = MTWebViewNavigationDelegate()
        webView.navigationDelegate = navigationDelegate
        webView.scrollView.showsVerticalScrollIndicator = false
        super.init()
        setupBindings()
    }
    
    @Published var urlString: String = ""
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var isLoading: Bool = false
    @Published var estimatedProgress: Double = 0
    @Published var title: String? = nil
    
    
    private func setupBindings() {
        webView.publisher(for: \.canGoBack)
            .assign(to: &$canGoBack)
        
        webView.publisher(for: \.canGoForward)
            .assign(to: &$canGoForward)
        
        webView.publisher(for: \.isLoading)
            .assign(to: &$isLoading)
        
        webView.publisher(for: \.estimatedProgress)
            .assign(to: &$estimatedProgress)
        
        webView.publisher(for: \.title)
            .assign(to: &$title)
        
    }
    
    func loadUrl(urlString: String) {
        self.urlString = urlString
        guard let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    
    
    func goForward() {
        webView.goForward()
    }
    
    func goBack() {
        webView.goBack()
    }
}
