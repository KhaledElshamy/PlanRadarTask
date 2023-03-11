//
//  CitiesFetcher.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import Foundation
import ObjectMapper

enum ResultApi<T:Mappable> {
    case success(T)
    case error(Error)
}

protocol CityWeatherFetcherDelegate {
    func fetchCityWeather(with city:String, completionHandler:@escaping ( ResultApi<CityWeatherResponse>)->Void)
}


class CityWeatherFetcher: CityWeatherFetcherDelegate {
    
    func fetchCityWeather(with city: String, completionHandler: @escaping (ResultApi<CityWeatherResponse>) -> Void) {
        
        let apiClient = APIClient.sharedInstance() as! APIClient
        let networkManager = CityWeatherNetworkManager()
        networkManager.configure(cityName: city)
        
        let Url = (networkManager.cityWeatherEndPoint?.baseURL ?? "") + (networkManager.cityWeatherEndPoint?.path.absolutePath ?? "")
        
        apiClient.sendRequest(withURL: Url,
                              parameters: networkManager.cityWeatherEndPoint?.bodyParams,
                              httpHeaders: networkManager.cityWeatherEndPoint?.headers,
                              httpMethod: networkManager.cityWeatherEndPoint?.httpMethod?.rawValue ?? "") { result, error in
            
            if error != nil {
                completionHandler(.error(error!))
            }else {
                let cityWeatherResponse = CityWeatherResponse(JSON: result as! [String: Any])
                completionHandler(.success(cityWeatherResponse!))
            }
        }
    }
}
