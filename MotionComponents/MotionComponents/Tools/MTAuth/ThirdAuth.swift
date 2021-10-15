//
//  GitHubAuth.swift
//  GitHubAuthExcample
//
//  Created by 梁泽 on 2021/9/27.
//

import Foundation
//import FirebaseAuth
import AuthenticationServices
import SafariServices



public class ThirdAuth: NSObject {
    enum Github {
        case lianze, zhuyiLocal, motion
    }
    public static let shared = ThirdAuth()
//    private let provider = OAuthProvider(providerID: "github.com") //firebase
    private var asSession: ASWebAuthenticationSession?
    private var appleController: ASAuthorizationController?
    
    
    private(set) var clientId: String = ""
    private(set) var clientSecret: String = ""
    private(set) var scopes: [String] = ["user", "admin:org", "repo"]
//    [
//        "user", "repo_deployment", "repo", "delete_repo", "notifications", "admin:org",
//        "admin:repo_hook", "gist","write:discussion", "write:packages", "read:packages",
//        "delete:packages", "admin:gpg_key", "workflow"
//    ]
    private(set) var callbackURLScheme: String? = "motion.native"
    
    override init() {
        super.init()
        let git = Github.zhuyiLocal
        switch git {
        case .lianze:
            configure(clientId: "9e8ee5130e06ce054096", clientSecret: "446b32b8b22103ff2a58b71577df9a88c11f3906")
        case .zhuyiLocal:
            configure(clientId: "b058a7554fe97d6f5315", clientSecret: "39647efd32fdf8e08efa76e8f6994b3dbddf2ddd")
        case .motion:
            configure(clientId: "abbcb9055e3df2b50fba", clientSecret: "ba55ceb8dd1bbf110105c3dfb9b680074d34325e")
        }
    }
    
    var githubSingInUrl: URL {
        assert(clientId.count > 0, "请检查clientId, 调用configure")
        var components = URLComponents(string: "https://github.com/login/oauth/authorize")
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "client_id", value: clientId))
        queryItems.append(URLQueryItem(name: "scope", value: scopes.joined(separator: ",")))
        queryItems.append(URLQueryItem(name: "state", value: "STATE"))

        components?.queryItems = queryItems
        let url = components?.url
        return  url!
    }
    
    public func configure(clientId: String,
                          clientSecret: String,
                          scopes: [String]? = nil,
                          callbackURLScheme: String? = nil) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        if let scopes = scopes {
            self.scopes = scopes
        }
        if let callbackURLScheme = callbackURLScheme  {
            self.callbackURLScheme = callbackURLScheme
        }
    }
    
    
    
    public static func start() {
//        let options = FirebaseOptions.defaultOptions()!
//        FirebaseApp.configure(options: options)
    }
    
    public func signIn(platform: Platform, completion: @escaping AuthCompletion) {
        switch platform {
        case .git(method: .firebase):
            break
//            fireBaseSignIn(completion: completion)
        case .git(method: .asAuth):
            asAuth(completion: completion)
        case .git(method: .safair):
            let vc = SFSafariViewController(url: githubSingInUrl)
            
            UIViewController.topMost?.present(vc, animated: true, completion: nil)
        case .git(method: .wkwebview):
            let vc = AuthWkWebVC(url: githubSingInUrl)
            UIViewController.topMost?.present(vc, animated: true, completion: nil)
        case .apple:
            appleSignInCompletion = completion
            appleSignIn()
        }
    }
    
    public func signOut(platform: Platform) {
        switch platform {
        case .git(method: .firebase):
//            fireBaseSignOut()
            break
        case .git(method: .asAuth):
            break
        case .git(method: .safair):
            break
        case .git(method: .wkwebview):
            break
        case .apple:
            break
        }
    }
    
    private var appleSignInCompletion: AuthCompletion?
    private func appleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        //        request.requestedScopes = [.fullName, .email]
        
//        let passwordRequest = ASAuthorizationPasswordProvider().createRequest()
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
}


extension ThirdAuth: ASWebAuthenticationPresentationContextProviding {
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        let r =  ASPresentationAnchor()
        r.tintColor = .red
        return r
        //        UIViewController.top
        
    }
}

extension ThirdAuth: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}

//MARK: - 苹果登录
extension ThirdAuth: ASAuthorizationControllerDelegate {
    // Successful authorization
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appCredentials = authorization.credential as? ASAuthorizationAppleIDCredential {
            //客户端至少要把苹果接口返回的identityToken, authorizationCode, userID这三个参数传给服务器，用于验证本次登录的有效性。
            let userId = appCredentials.user  
            var identityToken = ""
            if let data = appCredentials.identityToken {
                identityToken = String(data: data, encoding: .utf8) ?? ""
            }
            //            let fullName = appCredentials.fullName
            //            let email = appCredentials.email
            let result =  AuthResponse(platform: .apple, response: .apple(.init(appleUserid: userId, appleIdentityToken: identityToken)))
            appleSignInCompletion?(result)
        } else {
            appleSignInCompletion?(nil)
        }
    }
    
    // Error in authorization
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let er =  error as? ASAuthorizationError
//        _ = error as? NSError
        switch er?.code {
        case .canceled:
            print("用户取消")
        case .invalidResponse:
            print("invalidResponse")
        case .notHandled:
            print("notHandled")
        case .failed:
            print("failed")
        default:
            switch er?.code.rawValue {
            case -7001:
                print("没开")
            default:
                print("错误")
            }
        }
        appleSignInCompletion?(nil)
    }
    
}

//MARK: - AuthenticationServices GitHub
private extension ThirdAuth {
    func asAuth(completion: @escaping AuthCompletion) {
        asSession = ASWebAuthenticationSession(url: githubSingInUrl, callbackURLScheme: callbackURLScheme, completionHandler: { url, error in
            if let responseURL = url?.absoluteString {
                //motionnative://?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MyIsImV4cCI6MTYzMjg5MzU2M30.V7-t-NaeVQbXh_Vt1OeG9u8dUgbjOurJ13DgP77P43k
                let token = responseURL.components(separatedBy: "token=").last
                let result = AuthResponse(platform: .git(method: .asAuth), response: .git(.init(token: token ?? "")))
                completion(result)
                return
            }
            
            completion(nil)
        })
        asSession?.presentationContextProvider = self
        asSession?.prefersEphemeralWebBrowserSession = true
        asSession?.start()
    }
    
    func asCancel() {
        asSession?.cancel()
    }
}

//MARK: - FireBase
//private extension ThirdAuth {
//    func fireBaseSignIn(completion: @escaping AuthCompletion) { //signIn begin
//        provider.getCredentialWith(nil) { credential, error in
//            if error != nil {
//                //                return
//            }
//
//            if credential != nil {
//                Auth.auth().signIn(with: credential!) { authResult, error in
//                    if error != nil {
//                        // Handle error.
//                        completion(nil)
//                        return
//                    }
//
//
//                    let user = authResult?.user
//
//                    let response: AuthResponse
//                    if let oauthCredential = authResult?.credential as? OAuthCredential  {
//                        response = AuthResponse(platform: .git(method: .firebase), response: .git(.init(displayName: user?.displayName, photoURL: user?.photoURL?.absoluteString, email: user?.email, refreshToken: user?.refreshToken, accessToken: oauthCredential.accessToken)))
//
//                    } else {
//                        response = AuthResponse(platform: .git(method: .firebase), response: .git(.init(displayName: user?.displayName, photoURL: user?.photoURL?.absoluteString, email: user?.email, refreshToken: user?.refreshToken)))
//                    }
//
//                    completion(response)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//
//    }// signIn end
//
//    func fireBaseSignOut() {
//        try? Auth.auth().signOut()
//    }
//}
















private extension UIViewController {
    private class var sharedApplication: UIApplication? {
        let selector = NSSelectorFromString("sharedApplication")
        return UIApplication.perform(selector)?.takeUnretainedValue() as? UIApplication
    }
    
    /// Returns the current application's top most view controller.
    class var topMost: UIViewController? {
        guard let currentWindows = self.sharedApplication?.windows else { return nil }
        var rootViewController: UIViewController?
        for window in currentWindows {
            if let windowRootViewController = window.rootViewController, window.isKeyWindow {
                rootViewController = windowRootViewController
                break
            }
        }
        
        return self.topMost(of: rootViewController)
    }
    
    /// Returns the top most view controller from given view controller's stack.
    class func topMost(of viewController: UIViewController?) -> UIViewController? {
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
           let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
           pageViewController.viewControllers?.count == 1 {
            return self.topMost(of: pageViewController.viewControllers?.first)
        }
        
        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }
        
        return viewController
    }
}
