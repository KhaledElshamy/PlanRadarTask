//
//  EndPointType.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import Foundation

public typealias HTTPHeaders = [String:Any]
public typealias Parameters = [String:Any]

protocol EndPointType {
    associatedtype ResponseModel: Codable
    var baseURL: URL? { get }
    var path: URLs.Path { get }
    var httpMethod: HTTPMethod? { get }
    var headers: HTTPHeaders? { get }
    var bodyParams: Parameters? { get }
}

extension EndPointType {
    var baseURL: URL? {
        guard let url = URL(string: "https://api.openweathermap.org") else { return nil }
        return url
    }
}
