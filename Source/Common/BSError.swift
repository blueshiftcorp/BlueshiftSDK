//
// File name : BSError.swift

// Copyright (c) 2009-2021 Blueshift Corporation. All right reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  Created Blueshift on 2021/09/07
//

import Foundation

public enum BSError: Error {
    // common
    case unkown
    
//    // login
//    case idEmpty
//    case idFormat
//    case pwEmpty
//    case pwFormat
//    case idNoMatch
//    case pwNotMatch
//    case idPwNotMatch
    
    // webview
    case urlNotAvailable
    case notLoaded
    
    // API
    
}

extension BSError: LocalizedError {
    public var localizedDescription: String? {
        switch self {
            
        /// COMMON
        case .unkown:           return "BlueshiftSDK에서 알수없는 에러가 발생하였습니다."
            
        /// LOGIN
//        case .idEmpty:          return "아이디를 입력해주세요."
//        case .idFormat:         return "아이디 형식이 올바르지 않습니다.\n다시 입력해주세요."
//        case .idNoMatch:        return "일치하는 아이디가 없습니다."
//        case .pwEmpty:          return "비밀번호를 입력해주세요."
//        case .pwFormat:         return "비밀번호 형식이 올바르지 않습니다.\n다시 입력해주세요."
//        case .pwNotMatch:       return "비밀번호가 일치하지 않습니다."
//        case .idPwNotMatch:     return "아이디 혹은 비밀번호가 일치하지 않습니다."
            
        /// WEBVIEW
        case .urlNotAvailable:  return "URL이 유효하지 않습니다."
        case .notLoaded:        return "웹사이트가 정상적으로 로드되지 않았습니다."
            
        }
    }
}
