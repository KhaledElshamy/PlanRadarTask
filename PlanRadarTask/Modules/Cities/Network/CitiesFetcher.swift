//
//  CitiesFetcher.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import Foundation

enum ResultApi<T:Decodable> {
    case success(T)
    case error(Error)
}

protocol CityWeatherFetcherDelegate {
    func fetchCityWeather(with city:String, completionHandler:@escaping ( ResultApi<DailyTreasuryModel>)->Void)
}


class CityWeatherFetcher: CityWeatherFetcherDelegate {
    
    func fetchCityWeather(with city: String, completionHandler: @escaping (ResultApi<DailyTreasuryModel>) -> Void) {
        
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
                let decoder: JSONDecoder = JSONDecoder()
                
                do{
//                    guard let json = try JSONSerialization.jsonObject(with: result ,options: []) as? [String: Any] else {
//                        return
//                    }
//
//                    let responseModel = try decoder.decode(DailyTreasuryModel.self, from: result as! [String:Any])
//                    
//                    completionHandler(.success(responseModel))
                }catch(let error){
                    completionHandler(.error(error))
                }
            }
        }
    }
}
