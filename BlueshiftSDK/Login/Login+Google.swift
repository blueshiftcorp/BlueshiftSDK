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
import PromisedFuture

extension Login {
    
    public func withGoogle(_ clientId: String) -> Future<GIDGoogleUser, Error> {
        return Future { completion in
            let signInConfig = GIDConfiguration.init(clientID: clientId)
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self.parentVC) { user, error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                guard let user = user else { return }
                completion(.success(user))
                return
            }
        }
    }
}
