//
// File name : Enumeration.swift
// Project name: Blueshift Common Framework
// XCode Project name : BSCommon

// Copyright (c) 2021 iChrogene, Inc. All right reserved.

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

enum LoginType: String {
    case email = "0"
    case google = "1"
    case naver = "2"
    case kakaotalk = "3"
    case apple = "4"
}

enum LoginReturnCode: String {
    case success = "0"
    case notRegistered = "1"
}
