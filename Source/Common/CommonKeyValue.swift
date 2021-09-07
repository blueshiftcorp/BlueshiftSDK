//
// File name : KeyValue.swift

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

// 약어 정의
/*
 u : User
 l : Login
 r : Return, Related
 chk : Check
 cu : Current User
 f : Firebse
 cnt : Count
 min : Minimum
 max : Maximum
 t : Total
*/

//MARK:- Common
public let kEmail          = "email"           // eMail
public let kMobile         = "mobile"
public let kNickname       = "nick_name"
public let kGender         = "gender"          // 남성: 1, 여성: 0
public let kBirth          = "birth"           // yyyyMMdd
public let kPassword       = "password"        // 패스워드 Bcrypt를 이용한 암호화
public let kName           = "name"
public let kDi             = "di"              // 모바일 리턴값
public let kCo             = "co"              // 통신사
public let kMkt            = "mkt"             // 마케팅 및 상품안내를 위한 개인정보 제공 동의, Y 또는 N
