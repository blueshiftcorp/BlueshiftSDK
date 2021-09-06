//
// File name : APIRouter+Path.swift

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

extension APIRouter {
    internal var path: String {
        switch self {
        case .signup(.duplicate(.email)):       return CV.Url.iCare.Signup.Duplicate.email
        case .signup(.duplicate(.mobile)):      return CV.Url.iCare.Signup.Duplicate.mobile
        case .signup(.insert):                  return CV.Url.iCare.Signup.insert
            
        case .member(.info):                    return CV.Url.iCare.Member.info
        }
    }
}
