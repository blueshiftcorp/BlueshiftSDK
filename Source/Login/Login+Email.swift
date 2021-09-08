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
        
        do {
            guard try Util.Validate.email(email), try Util.Validate.password(password) else { return }
            
            delegate?.requestToServer()
        } catch {
            switch error {
            case BSError.Validation.invalidEmailFormat:
                parentVC.showToast(message: BSError.Validation.invalidEmailFormat.localizedDescription)
                return
            case BSError.Validation.invalidPasswordFormat:
                parentVC.showToast(message: BSError.Validation.invalidPasswordFormat.localizedDescription)
                return
            default: break
            }
        }
        
        //TODO: Development Only **********************
//        self.completeLogin(sUser())
        return
        //**********************************************
        
        
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
}
