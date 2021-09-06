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
let kEmail          = "email"           // eMail
let kMobile         = "mobile"
let kNickname       = "nick_name"
let kGender         = "gender"          // 남성: 1, 여성: 0
let kBirth          = "birth"           // yyyyMMdd
let kPassword       = "password"        // 패스워드 Bcrypt를 이용한 암호화
let kName           = "name"
let kDi             = "di"              // 모바일 리턴값
let kCo             = "co"              // 통신사
let kMkt            = "mkt"             // 마케팅 및 상품안내를 위한 개인정보 제공 동의, Y 또는 N
