//
//  File name : APIReturnCodeConfiguration.swift
//
//  Copyright (c) 2009-2021 Blueshift Corporation. All right reserved.
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
//  Created by Blueshift on 2021/11/24
//

/// API ReturnCode 처리
///
/// API로부터 전달된 ReturnCode를 처리하기 위한 구성입니다.
/// API에서 전달된 ReturnCode를 enum으로 분기하여 사용자에게 alert을 표시해야하는 메세지와 개발자 혹은 관리자에게 알려야할 message를 구분하여 처리합니다.
///
/// - Example
/// ```
/// enum APIRetrunCode: APIReturnCodeConfiguration {
///     case APIReturn100
///     case APIReturn200
///     case APIRetrun300
///
///     var alertTitle: String? {
///         switch self {
///         case .APIReturn100: return "호출성공"
///         default: return nil
///         }
///     }
///
///     var alertMessage: String? {
///     ...
///     }
///
///     var debugMessage: String? {
///     ...
///     }
/// }
///
///
///
/// ```
protocol APIResponseCodeConfiguration {
    
    /// 사용자 알림 메세지 타이틀
    ///
    /// 알림메세지 타이틀이 필요한 경우 타이틀을 정의합니다.
    /// 타이틀이 없을 경우 nil
    var alertTitle: String? { get }
    
    
    /// 사용자 알림 문구
    ///
    /// 사용자에게 알림팝업 등으로 알려야할 문구를 정의합니다.
    /// 사용자에게 알릴필요 없는 returnCode인 경우 nil
    var alterMessage: String? { get }
    
    /// 개발자 혹은 관리자 알림 문구
    ///
    /// 개발자 혹은 관리자에게 DEBUG용 앱이나 Log 등으로 알려야할 문구를 정의합니다.
    /// 알림문구가 없는 경우 nil
    var debugMessage: String? { get }
}
