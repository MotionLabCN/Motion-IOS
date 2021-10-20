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
            let urlStr = url.absoluteString ?? ""
            
            // 此处拦截支付宝支付
            if urlScheme == "alipay" || urlScheme == "alipays" {
                    
                // 此处是为处理支付宝支付链接的 scheme（解决支付完成后无法返回app的问题）
//                let aliPayUrl = handleAlipayUrl(url: navigationAction.request.url!)

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
    
    fileprivate func handleAlipayUrl(url: URL) -> URL? {
        
        if url.absoluteString.hasPrefix("alipays://platformapi/") {
            // 更换scheme
//            let aliurl = URL(string: urlString?.replacingOccurrences(of: "alipays", with: "my"))!
//            let aliurl = URL(string: url.absoluteString.replacingOccurrences(of: "alipays", with: "motionNative"))!
//            let aliurl = url.absoluteString + "&fromAppUrlScheme=motionNative"
//            var decodePar = url.query ?? ""
//            decodePar = decodePar.urlDecoded()
//            var dict = self.stringValueDic(decodePar)
//            dict?["fromAppUrlScheme"] = "你app的scheme"
//            if let strData = try? JSONSerialization.data(withJSONObject: dict as Any , options: []) {
//                var param = String(data: strData, encoding: .utf8)
//                param = param?.urlEncoded()
//                let finalStr = "alipays://platformapi/?\(param ?? "")"
//                return URL(string:finalStr)
//            }
            return url
        }
        return nil
    }


    func stringValueDic(_ str: String) -> [String : Any]?{
        let data = str.data(using: String.Encoding.utf8)
        
        if let dict = try?
            JSONSerialization.jsonObject(with: data!,
                        options: .mutableContainers) as? [String : Any] {
            return dict
        }

        return nil
    }
}

//扩展类
extension String {
//将原始的url编码为合法的url
func urlEncoded() -> String {
    let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
        .urlQueryAllowed)
    return encodeUrlString ?? ""
  }
 
//将编码后的url转换回原始的url
func urlDecoded() -> String {
    return self.removingPercentEncoding ?? ""
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
