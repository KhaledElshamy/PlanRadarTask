//
//  CitiesListViewControllerTest.swift
//  PlanRadarTaskTests
//
//  Created by Khaled Elshamy on 11/03/2023.
//

import XCTest
@testable import PlanRadarTask

final class CitiesListViewControllerTest: XCTestCase {

    func test_numberOfCities_WithZeroElement() {
        XCTAssertEqual(makeSUT().cities.count, 0)
    }
    
    func test_NumberOfCities_WithSomeElements(){
        let sut = makeSUT()
        sut.viewModel?.fetchCityWeatherDetails()
        XCTAssertEqual(sut.cities.count, 1)
    }
    
    func makeSUT() -> CitiesListViewController {
        let dataController = DataController(modelName: "PlanRadarTask")
        let weatherLocalStorageMock = CityWeatherLocalStorageMock(dataController: dataController)
        let cityWeatherFetcherMock = CityWeatherFectherMock()
        let viewModelMock = CitiesListMockViewModel(cityWeatherLocalStorage: weatherLocalStorageMock,
                                                    cityWeatherFetcher: cityWeatherFetcherMock)
        let vc = CitiesListViewController()
        vc.viewModel = viewModelMock
        return vc
    }
}


// MARK: - Mocking viewModel

class CitiesListMockViewModel:CitiesViewModelDelegate {
    
    @Published var dataSource: [String] = []
    var namePublisher: Published<[String]>.Publisher {$dataSource}
    
    private var cityName: String?
    private var cityWeatherFetcher:CityWeatherFetcherDelegate?
    private var cityWeatherLocalStorage:CityWeatherLocalStorrageDelegate?
    
    init(cityWeatherLocalStorage:CityWeatherLocalStorrageDelegate,cityWeatherFetcher:CityWeatherFetcherDelegate){
        self.cityWeatherFetcher = cityWeatherFetcher
        self.cityWeatherLocalStorage = cityWeatherLocalStorage
    }
    
    func fetchCityWeatherDetails() {
        cityWeatherFetcher?.fetchCityWeather(with: cityName ?? "", completionHandler: { [weak self] result in
            switch result {
            case .success(let model):
                self?.dataSource = ["london"]
//                let city = self?.getCityModel(model: model)
//                self?.cityWeatherLocalStorage?.addWeather(for: city!)
//                self?.dataSource = self?.cityWeatherLocalStorage?.getCitiesNames() ?? []
                break
            case .error(let error):
                print(error.localizedDescription)
                break
            }
        })
    }
    
    private func getCityModel(model:CityWeatherResponse) -> City {
        let baseURL = ConfigurationManager.baseURL
        let imageURL = baseURL + (URLs.Path.weatherIcon(iconId: model.weather?.first?.icon ?? "").absolutePath)
        return City(name: self.cityName ?? "",
                    description: model.weather?.first?.description ?? "",
                    humidity: "\(model.main?.humidity ?? 0)",
                    windSpeed: "\(model.wind?.speed ?? 0)",
                    temperature: "\(model.main?.temprature ?? 0.0)",
                    imageURL: imageURL)
    }
    
    func setCityName(to name: String) {
        cityName = name
    }
    
    func deleteCity(at index: Int) {
        
    }
    
    func getWeatherInfo(at index: Int) -> PlanRadarTask.City {
        return (cityWeatherLocalStorage?.getCityDetails(at: index).first)!
    }
    
    func getWeatherInfoHistory(at index: Int) -> [PlanRadarTask.City] {
        return cityWeatherLocalStorage?.getCityDetails(at: index) ?? []
    }
}


 // MARK: -  Mocking City Weather Local Storage

class CityWeatherLocalStorageMock: CityWeatherLocalStorrageDelegate {
    
    private var cities: [CityModel] = []
    private var dataController:DataController?
    
    init(dataController:DataController){
        self.dataController = dataController
        self.dataController?.load()
    }
    
    private func getCityIndex(name: String) -> Int? {
        return cities.firstIndex(where: {$0.name == name})
    }
    
    private func loadLocalCities(){
        do {
            guard let dataController = self.dataController else {return}
            cities = try dataController.viewContext.fetch(CityModel.fetchRequest())
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func getCitiesNames() -> [String] {
        return cities.map {$0.name}
    }
    
    func addWeather(for city: PlanRadarTask.City) {
        if let cityIndex = getCityIndex(name: city.name) {
            
        }else {
            addNewCity(city)
        }
    }
    
    private func addNewCity(_ model:City){
        if let dataController = self.dataController {
            let city = CityModel(context: dataController.viewContext)
            city.name = model.name
            let weather = getWeatherInfoModel(for:model)
            weather?.city = city
            dataController.saveContext()
            
            cities.append(city)
        }
    }
    
    private func getWeatherInfoModel(for model: City) -> WeatherInfoModel? {
        if let dataController = self.dataController {
            let weather = WeatherInfoModel(context: dataController.viewContext)
            weather.humidity = model.humidity
            weather.imageURL = model.imageURL
            weather.wind =  model.windSpeed
            weather.temperature = model.temperature
            weather.descriptionInfo = model.description
            weather.timeTemp = Date()
            return weather
        }
        return nil
    }
    
    func deleteCity(with index: Int) {
        let city = cities[index]
        guard let dataController = self.dataController else {return}
        dataController.viewContext.delete(city)
        dataController.saveContext()
    }
    
    func getCityDetails(at index: Int) -> [PlanRadarTask.City] {
        loadLocalCities()
        let city = cities[index]
        let weathers = city.weathers
        let models: [City] = weathers.map({
            City(name: city.name, description: $0.descriptionInfo, humidity: $0.humidity, windSpeed: $0.wind, temperature: $0.temperature, imageURL: $0.imageURL, timeTemp: $0.timeTemp)
            
        })
        let orderModel = models.sorted { a, b in
            a.timeTemp!  > b.timeTemp!
        }
        return orderModel
    }
}


// MARK: - Mocking Weather featcher

class CityWeatherFectherMock:CityWeatherFetcherDelegate {
    
    func fetchCityWeather(with city: String, completionHandler: @escaping (PlanRadarTask.ResultApi<PlanRadarTask.CityWeatherResponse>) -> Void) {
        completionHandler(.success(CityWeatherResponse(weather: [Weather(description: "Cloudy", icon: "")],
                                                       main: Main(temprature: 298, humidity: 36), wind: Wind(speed: 3.09), timezone: 11)))
    }
}
