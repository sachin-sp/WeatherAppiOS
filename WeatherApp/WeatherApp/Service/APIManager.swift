//
//  APIManager.swift
//  WeatherApp
//
//  Created by Sachin on 03/03/21.
//

import Foundation
import Alamofire


class APIManager: NSObject {
    
    //MARK: Singleton
    static let shared = APIManager()
    private override init() {}
    
    let queue = DispatchQueue(label: "com.goalsr.WeatherApp", qos: .utility, attributes: [.concurrent])
    
    var sessionManager: SessionManager {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        return manager
    }
    
    
    enum APIError: Error {
        case JSONSerialization
        case responseData
        case nilJson
        case timeOut
    }
    
    func fetchWeather(completionHandler: @escaping (_ result: [String: Any]?, _ error: Error?) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/find?lat=31.086286&lon=76.452690&cnt=10&appid=2699bd1f1e79cd9206dd756e64cec43d"
        
        sessionManager.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
        .response(
            queue: queue,
            responseSerializer: DataRequest.jsonResponseSerializer(),
            completionHandler: { response in
                
                switch (response.result) {
                case .success: // succes path
                    do {
                        guard let data = response.data else {
                            completionHandler(nil, APIError.responseData)
                            return
                        }
                        let json: [String: Any]? = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                        DispatchQueue.main.async {
                            guard let json = json else {
                                completionHandler(nil, APIError.nilJson)
                                return
                            }
                            completionHandler(json, nil)
                            
                        }
                        
                    } catch _ as NSError {
                        DispatchQueue.main.async {
                            completionHandler(nil, APIError.JSONSerialization)
                        }
                    }
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        print("Request timeout!")
                        completionHandler(nil, APIError.timeOut)
                    }
                    print(error.localizedDescription)
                }
                
        })
    
    }
    
    
}
