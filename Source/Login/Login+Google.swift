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

// Created by James, Blueshift Corporation on 2021/08/17
// Website : www.blueshift.co.kr
// Email : admin@blueshift.co.kr
//

import Foundation
import GoogleSignIn

extension Login {
    
    internal func withGoogle() {
        
        let signInConfig = GIDConfiguration.init(clientID: CV.SocialLogin.Google.clientId)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self.parentVC) { user, error in
            guard error == nil else {
                print("구글 로그인 중 오류가 발생했습니다 : \(error!)")
                return
            }
            
            let email = user?.profile?.email
            let fullName = user?.profile?.givenName
            let token = user?.authentication.idToken
            //TODO: 회원가입인 경우 추가 정보 입력(회원가입) 화면으로 이동
            //TODO: 로그인인 경우 첫화면으로 이동
            
            //TODO: Development Only
            self.completeLogin(sUser())
            return
        }
    }
}
