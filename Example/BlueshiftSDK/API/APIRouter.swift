//
//  File name : APIEndPoint.swift
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
//  Created by Blueshift on 2021/09/08
//

import Alamofire
import Foundation
import BlueshiftSDK

public enum APIRouter: APIConfiguration {
    
    case member(eMember)
    
    public func asURLRequest() throws -> URLRequest {
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
//        urlRequest.setValue(CV.API.accessKey, forHTTPHeaderField: HTTPHeaderField.hdr_acckey.rawValue)
//        urlRequest.setValue(hdr_sign, forHTTPHeaderField: HTTPHeaderField.hdr_sign.rawValue)
        
        guard let params = parameters as? [String: String] else { return urlRequest }
        switch method {
        case .get:
            urlRequest = try URLEncodedFormParameterEncoder().encode(params, into: urlRequest)
        case .post:
            urlRequest = try JSONParameterEncoder().encode(params, into: urlRequest)
        default: break
        }
        
        print("URL Request = \(urlRequest)")
        return urlRequest
    }
    
    public var multipartFormData: MultipartFormData? {
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
