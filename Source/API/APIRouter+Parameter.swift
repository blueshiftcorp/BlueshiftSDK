//
// File name : APIRouter+Parameter.swift

// Copyright (c) 2021 Blueshift Corporation. All right reserved.

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

import Alamofire

extension APIRouter {
    
    internal var parameters: [String:String]? {
        
        var params = [String:String]()
//        params[kCuIdx] = Pref.uIdx
//        params[kToken] = Pref.loginToken
        
        switch self {
            
            
        //MARK:- SignUp
            
        case .signup(.duplicate(.email(email: let email))):
            params[kEmail] = email
            
        case .signup(.duplicate(.mobile(mobile: let mobile))):
            params[kMobile] = mobile
            
        case .signup(.insert(nick_name: let nickName, mobile: let mobile, email: let email, gender: let gender, birth: let birth, password: let password, name: let name, di: let di, co: let co, mkt: let mkt)):
            params[kNickname] = nickName
            params[kMobile] = mobile
            params[kEmail] = email
            params[kGender] = gender
            params[kBirth] = birth
            params[kPassword] = password
            params[kName] = name
            params[kDi] = di
            params[kCo] = co
            params[kMkt] = mkt
            
            //MARK:- Member
        case .member(.info(email: let email)):
            params[kEmail] = email
        }
            
        return params
    }
}
