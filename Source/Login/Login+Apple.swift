//
// File name : Login+Apple.swift
// Project name: Blueshift Common Framework
// XCode Project name : BSCommon

// Copyright (c) 2021 iChrogene, Inc. All right reserved.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

// Created by James, Blueshift Corporation on 2020/06/22
// Website : www.blueshift.co.kr
// Email : admin@blueshift.co.kr
//

import Foundation
import AuthenticationServices

extension Login {
    
    internal func withApple() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
    
    private func doLogin(auth: ASAuthorizationAppleIDCredential) {
        guard let token = auth.identityToken?.hexEncodedString() else { return }
//        guard let request = API.User.login(lCode: .apple, uId: auth.user, uPw: token) else { return }
//
//        request.execute { (result) in
//            switch result {
//            case .success(let value):
//
//                //TODO: Development Only
//                self.completeLogin(sUser())
//                return
//
//            //TODO: 로그인 성공
//            //TODO: 회원가입 필요
//                self.doRegister(auth: auth)
//            case .failure(let error):
//                NSLog("Error occurred while logging in with KakaoTalk : \(error)")
//            }
//        }
    }
    
    private func doRegister(auth: ASAuthorizationAppleIDCredential) {
        
        guard let email = auth.email else { return }
        guard let name = auth.fullName?.nickname else { return }
        guard let token = auth.identityToken?.hexEncodedString() else { return }
        
//        let pUser = sUser(uId: auth.user, uNick: name, uEmail: email, uPw: token)
//        guard let request = API.User.add(lCode: .apple, UserInfo: pUser) else { return }
//        request.execute { (result) in
//            switch result {
//            case .success(let value): break
//            //TODO: 회원가입 성공
//                self.doLogin(auth: auth)
//            //TODO: 회원가입 실패
//            case .failure(let error): break
//            }
//        }
    }
}

extension Login: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        self.doLogin(auth: appleIDCredential)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.parentVC.view.window!
    }
}
