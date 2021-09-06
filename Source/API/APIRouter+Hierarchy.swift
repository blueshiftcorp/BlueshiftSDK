//
// File name : APIRouter+Hierarchy.swift
// Project name: Blueshift Common Framework
// XCode Project name : BSCommon

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

import Foundation

extension APIRouter {
    
    enum eSignup {
        case duplicate(eDuplicate)
        case insert(nick_name: String, mobile: String, email: String, gender: String, birth: String, password: String, name: String, di: String, co: String, mkt: String)
    }
    
    enum eDuplicate {
        case email(email: String)
        case mobile(mobile: String)
    }
    
    enum eMember {
        case info(email: String)
    }
}
