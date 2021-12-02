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
import NaverThirdPartyLogin
import Alamofire
import PromisedFuture

extension Login {
    
    public struct NaverUserInfo: Decodable {
        public let name: String?
        public let email: String?
        public let nickname: String?
        public let token: String
    }
    
    public func withNaver() -> Future<NaverUserInfo, Error> {
        return Future { completion in
            guard let login = NaverThirdPartyLoginConnection.getSharedInstance() else {
                print("네이버 로그인 중 컨넥션을 생성하지 못했습니다.")
                return
            }
            
            if login.isValidAccessTokenExpireTimeNow() {
                login.requestDeleteToken()
            }
//            login.delegate = self
            login.requestThirdPartyLogin()
            
            self.completionForNaver = completion
        }
    }
    
}

extension Login: NaverThirdPartyLoginConnectionDelegate {
    public func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow(), isValidAccessToken else { return }
        guard let tokenType = loginInstance?.tokenType else { return }
        guard let accessToken = loginInstance?.accessToken else { return }
        let url = URL(string: "")!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON { response in
            
            switch response.result {
            case .success(let value):
                guard let json = value as? [String: Any] else { return }
                guard let object = json["response"] as? [String: Any] else { return }
                guard let name = object["name"] as? String else { return }
                guard let email = object["email"] as? String else { return }
                guard let nickname = object["nickname"] as? String else { return }
                let userInfo = NaverUserInfo(name: name, email: email, nickname: nickname, token: accessToken)
                guard let completion = self.completionForNaver else { return }
                completion(.success(userInfo))
                
            case .failure(let error):
                print("네이버 사용자 정보 요청 중 오류가 발생했습니다: \(error.localizedDescription)")
            }
        }
    }
    
    public func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        
    }
    
    public func oauth20ConnectionDidFinishDeleteToken() {
        let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        loginInstance?.requestDeleteToken()
    }
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("네이버 로그인 관련 오류 : \(error.localizedDescription)")
    }
    
    
}
