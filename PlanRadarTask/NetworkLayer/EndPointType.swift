//
//  EndPointType.swift
//  PlanRadarTask
//
//  Created by Khaled Elshamy on 10/03/2023.
//

import Foundation
import ObjectMapper

public typealias HTTPHeaders = [String:Any]
public typealias Parameters = [String:Any]

protocol EndPointType {
    associatedtype ResponseModel: Mappable
    var baseURL: String? { get }
    var path: URLs.Path { get }
    var httpMethod: HTTPMethod? { get }
    var headers: HTTPHeaders? { get }
    var bodyParams: Parameters? { get }
}

extension EndPointType {
    var baseURL: String? {
        return ConfigurationManager.baseURL
    }
}
