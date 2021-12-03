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
import PromisedFuture

extension Login {
    
    public struct AppleUserInfo {
        public let email: String
        public let name: String
        public let token: String
    }
    
    public func withApple() -> Future<AppleUserInfo, Error> {
        return Future { completion in
            self.completionForApple = completion
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
}

extension Login: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        
        guard let email = appleIDCredential.email else { return }
        guard let name = appleIDCredential.fullName?.nickname else { return }
        guard let token = appleIDCredential.identityToken?.hexEncodedString() else { return }
        
        guard let completion = self.completionForApple else { return }
        let userInfo = AppleUserInfo(email: email, name: name, token: token)
        completion(.success(userInfo))
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //
    }
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.parentVC.view.window!
    }
}
