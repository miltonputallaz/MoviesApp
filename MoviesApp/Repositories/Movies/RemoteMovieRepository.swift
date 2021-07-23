//
//  RemoteMovieRepository.swift
//  MoviesApp
//
//  Created by Milton Putallaz on 30/06/2021.
//

import Foundation
import Alamofire
import AlamofireImage

struct RemoteMovieRepository {
    
    static let sharedInstance = RemoteMovieRepository()
    private let genericRemoteRepository = GenericRemoteRepository.sharedInstance
    
    private let url = ConfigUtils.infoForKey(ConfigKeys.baseUrlConfigName)
    private let apiKey = ConfigUtils.infoForKey(ConfigKeys.moviesApiKey)
    private let discoverMoviesEndpoint = "/discover/movie"
    private let movieDetailEndpint = "/movie"
    private let movieGenresEndpoint = "/genre/movie/list"
    
    private init(){
        
    }
    
    func getListOfMovies(genreId: Int?, completion: @escaping (ListResponse<Movie>?, BackendError?) -> ()){
        if let unwrappedUrl = url, let unwrappedKey = apiKey{
            var endpointUrl = "\(unwrappedUrl+discoverMoviesEndpoint)?api_key=\(unwrappedKey)"
            
            if let genreIdent = genreId {
                endpointUrl += "&with_genres=\(genreIdent)"
            }
            print(endpointUrl)
            genericRemoteRepository.getListFrom(url: endpointUrl, completion: completion)
        }
    }
    
    
    func getMovieDetail(movieId: Int, completion: @escaping (Movie?, BackendError?) -> ()) {
        if let unwrappedUrl = url, let unwrappedKey = apiKey{
            var endpointUrl = "\(unwrappedUrl+movieDetailEndpint)/\(movieId)?api_key=\(unwrappedKey)"
            print(endpointUrl)
            genericRemoteRepository.getSingleEntity(url: endpointUrl, completion: completion)
        }
    }

    
    
    func getImageFromUrl(imagePath path: String,  completion: @escaping (UIImage?, BackendError?) -> ()) {
        if let imageEndpoint = ConfigUtils.infoForKey(ConfigKeys.imagesMiniUrl),
           let apiKey = ConfigUtils.infoForKey(ConfigKeys.moviesApiKey){
            genericRemoteRepository.getImageFrom(url: "\(imageEndpoint+path)?api_key=\(apiKey)", completion: completion)
        }
    }
    
    func getArrayOf<T: Codable> (completion: @escaping (ArrayResponse<T>?, BackendError?) -> ()){
        if let unwrappedUrl = url, let unwrappedKey = apiKey{
            let endpointUrl = "\(unwrappedUrl+movieGenresEndpoint)?api_key=\(unwrappedKey)"
            AF.request(endpointUrl).responseJSON(){response in
                
                switch response.result {
                    case .success(let data):
                        if let code = response.response?.statusCode{
                            switch code {
                                case 200...299:
                                    do {
                                        let listResponse = try JSONDecoder().decode(ArrayResponse<T>.self, from: response.data!)
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
}
