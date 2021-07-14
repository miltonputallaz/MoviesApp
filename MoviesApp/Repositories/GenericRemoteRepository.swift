//
//  GenericRepository.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 14/07/2021.
//

import Foundation
import Alamofire

struct GenericRemoteRepository {
    
    static let sharedInstance = GenericRemoteRepository()
    
    private init() {
        
    }
    
    func getListFrom<T: Codable>(url: String, completion: @escaping (ListResponse<T>?, BackendError?) -> ()){
        
            AF.request(url).responseJSON(){response in
                
                switch response.result {
                    case .success(let data):
                        if let code = response.response?.statusCode{
                            switch code {
                                case 200...299:
                                    do {
                                        let listResponse = try JSONDecoder().decode(ListResponse<T>.self, from: response.data!)
                                        completion(listResponse, nil)
                                    } catch let parsingError {
                                        print("Error parsing")
                                    }
                                    break;
                                case 400...404:
                                    do {
                                        print(String(data: response.data!, encoding: .utf8)!)
                                        let backendError = try JSONDecoder().decode(BackendError.self, from: response.data!)
                                        completion(nil, backendError)
                                    } catch let parsingError {
                                        print("Error parsing")
                                    }
                                    break;
                                default:
                                    print("error")
                                    break;
                            }
                        }
                        break;
                    case .failure(let error):
                        if let httpStatusCode = response.response?.statusCode, let errorData = response.data {
                            switch httpStatusCode {
                            
                            default:
                                print("error")
                            }
                            break;
                        }
            
            }
        }
       
    }
    
}
