//
// File name : Login+Email.swift
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

extension Login {
    
    internal func withEmail(_ _email: String?, _ _password: String?){
        
        guard let email = _email else { return }
        guard let password = _password else { return }
        
        let valid = Validation()
        do {
            guard try valid.email(email), try valid.password(password) else { return }
        } catch {
            switch error {
            case ICError.Validation.invalidEmailFormat: break
                parentVC.showToast(message: ICError.Validation.invalidEmailFormat.localizedDescription)
                return
            case ICError.Validation.invalidPasswordFormat: break
                parentVC.showToast(message: ICError.Validation.invalidPasswordFormat.localizedDescription)
                return
            default: break
            }
        }
        
        //TODO: Development Only
        self.completeLogin(sUser())
        return
        
//        guard let request = API.User.login(lCode: .email, uId: email, uPw: password) else { return }
//        request.execute(completion: { result in
//            switch result {
//            case .success(let value):
//                switch value.rCode {
//                case 0:
//                    self.completeLogin(value.result!)
//                default: break
//                }
//                
//                break
//            case .failure(let error):
//                NSLog("Error occurred while requesting email login: \(error)")
//            }
//        })
    }
    
//    func a() {
//
//        let newAccount = ""
//        let newPassword = ""
//        do {
//            let passwordItem = KeychainItem(service: CV.KeychainConfiguration.serviceName,
//                                                    account: newAccount,
//                                                    accessGroup: CV.KeychainConfiguration.accessGroup)
//
//            try passwordItem.savePassword(newPassword)
//        } catch {
//
//            fatalError("Error updating keychain - \(error)")
//        }
//
//
//    }
}
