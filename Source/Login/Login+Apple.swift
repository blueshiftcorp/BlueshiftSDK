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
        /// 사용자 관리를 위해 토큰이 필요한 경우 사용
//        guard let token = auth.identityToken?.hexEncodedString() else { return }
    }
    
    private func doRegister(auth: ASAuthorizationAppleIDCredential) {
        
        /**
         사용자 이메일 : auth.email
         사용자 이름 : auth.name
         */
//        guard let email = auth.email else { return }
//        guard let name = auth.fullName?.nickname else { return }
//        guard let token = auth.identityToken?.hexEncodedString() else { return }
        
    }
}

extension Login: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        self.doLogin(auth: appleIDCredential)
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //
    }
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.parentVC.view.window!
    }
}
