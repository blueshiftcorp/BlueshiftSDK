//
// File name : API.swift

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
import PromisedFuture

public class API {
    @discardableResult
    
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder()) -> Future<T, Error>? {
        return Future(operation: { completion in
            
            AF.request(route)
                .responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                        
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })
                .responseString(completionHandler: { (resopnse) in
                    print("received string from server: \(resopnse)")
                })
                .responseJSON { (response) in
                    print("received data from server : \(response)")
                }
        })
    }

    private static func performUploadMultipartFormData<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder()) -> Future<T, Error>? {
        return Future(operation: { completion in
            AF.upload(multipartFormData: route.multipartFormData, with: route)
            .uploadProgress(closure: { (progress) in
                print("image upload progress: \(progress)")
            })
            .responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            })
            .responseString(completionHandler: { (resopnse) in
                print("received string from server: \(resopnse)")
            })
            .responseJSON { (response) in
                print("received data from server : \(response)")
            }
            
        })
    }
    
    
    //MARK:-
    public class Signup {
        
        public class Duplicated {
            public static func email(email: String) -> Future <ServerResponse.SignUp.Duplication, Error>? {
                return API.performRequest(route: .signup(.duplicate(.email(email: email))))
            }
            
            public static func mobile(mobile: String) -> Future <ServerResponse.SignUp.Duplication, Error>? {
                return API.performRequest(route: .signup(.duplicate(.mobile(mobile: mobile))))
            }
        }
        
        public static func insert(nick_name: String, mobile: String, email: String, gender: String, birth: String, password: String, name: String, di: String, co: String, mkt: String) -> Future <ServerResponse.SignUp.Insert, Error>? {
            return API.performRequest(route: .signup(.insert(nick_name: nick_name, mobile: mobile, email: email, gender: gender, birth: birth, password: password, name: name, di: di, co: co, mkt: mkt)))
        }
    }
    
    //MARK:-
    public class Member {
        public static func info(email: String) -> Future <ServerResponse.Member.Info, Error>? {
            return API.performRequest(route: .member(.info(email: email)))
        }
    }
}
