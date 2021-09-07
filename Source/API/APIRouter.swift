//
// File name : APIRouter.swift

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
import Foundation

internal enum APIRouter: URLRequestConvertible {
    
    case signup(eSignup)
    case member(eMember)
    
    private var method: HTTPMethod {
        switch self {
        //TODO: POST로 보내야하는 API는 case로 추가
        default: return .get
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try (CV.Url.host + path).asURL()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let hdr_timestamp = dateFormatter.string(from: Date())
        
//        let hdr_sign = Util.AES256.encrypt(string: method.rawValue
//                                                 + "^"
//                                                 + path
//                                                 + "^"
//                                                 + hdr_timestamp
//                                                 + "^"
//                                                 + CV.API.accessKey)
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(hdr_timestamp, forHTTPHeaderField: HTTPHeaderField.hdr_timestamp.rawValue)
        urlRequest.setValue(CV.API.accessKey, forHTTPHeaderField: HTTPHeaderField.hdr_acckey.rawValue)
//        urlRequest.setValue(hdr_sign, forHTTPHeaderField: HTTPHeaderField.hdr_sign.rawValue)
        
        switch method {
        case .get:
            urlRequest = try URLEncodedFormParameterEncoder().encode(parameters, into: urlRequest)
        case .post:
            urlRequest = try JSONParameterEncoder().encode(parameters, into: urlRequest)
        default: break
        }
        
        print("URL Request = \(urlRequest)")
        return urlRequest
    }
    
    var multipartFormData: MultipartFormData {
        let multipartFormData = MultipartFormData()
        switch self {
        
//        case .item(.add(iCode: _, images: let images, ct1: _, ct2: _, ct3: _, title: _, desc: _, minOrder: _, price: _, rIIdx: _)):
//            guard let params = parameters else { break }
//            for (key, value) in params {
//                guard let v = value as? String else { continue }
//                multipartFormData.append(v.data(using: .utf8)!, withName: key)
//            }
//            
//            for (index, image) in images.enumerated() {
//                multipartFormData.append(image, withName: "attachFiles[]", fileName: "attach_\(index).jpg", mimeType: "image/jpg")
//            }
//            
            
        default: break
        }
        
        return multipartFormData
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case hdr_timestamp = "hdr-timestamp"
    case hdr_acckey = "hdr-acckey"
    case hdr_sign = "hdr-sign"
}

enum ContentType: String {
    case json = "application/json; charset=utf-8"
    case multipartData = "multipart/form-data"
}
