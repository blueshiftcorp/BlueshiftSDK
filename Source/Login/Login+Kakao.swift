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
import KakaoSDKAuth
import KakaoSDKUser
import PromisedFuture

extension Login {
    
    public struct KakaoUserInfo {
        public let userInfo: User
        public let token: String
    }
    
    
    public func withKakao() -> Future<KakaoUserInfo, Error> {
        return Future { completion in
            self.getUserToken()
                .map({$0})
                .andThen(self.getUserInfo)
                .execute { result in
                    completion(result)
                }
        }
    }
    
    private func getUserToken() -> Future<String, Error> {
        return Future { completion in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { _oauthToken, error in
                    
                    guard error == nil else {
                        completion(.failure(error!))
                        return
                    }
                    
                    guard let token = _oauthToken?.accessToken else { return }
                    completion(.success(token))
                }
            } else {
                
            }
        }
    }
    
    private func getUserInfo(_ token: String) -> Future<KakaoUserInfo, Error> {
        return Future { completion in
            UserApi.shared.me { user, error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                guard let user = user else { return }
                let userInfo = KakaoUserInfo(userInfo: user, token: token)
                completion(.success(userInfo))
            }
        }
    }
}
