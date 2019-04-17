//
//  HomeApi.swift
//  MoyaDemo
//
//  Created by tenltrs on 2019/4/16.
//  Copyright © 2019 Tenltrs. All rights reserved.
//

import Moya
import SwiftyJSON

enum HomeApi: BaseApi {
    
    case saveName(name : String)
    case saveList(list : [String])
}

extension HomeApi {
    
    var path: String {
        switch self {
        case .saveName:
            return "/app/goods/saveName"
        case .saveList:
            return "/app/goods/saveList"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .saveName, .saveList:
            return .post
        default:
            return .get
        }
    }
    
    var cacheType: ApiCacheType {
        switch self {
        case .saveList, .saveName:
            return .cache
        default:
            return .none
        }
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .saveName(let name):
            return .requestParameters(parameters: ["name": name], encoding: URLEncoding.default)
        case .saveList(let list):
            do {
                let data = try JSON.init(list).rawData()
                return .requestData(data)
            } catch {
                return .requestPlain
            }
        }
    }
    
    var headers: [String : String]? {
        var headers : [String: String] = [:]
        switch self {
        case .saveList:
            headers["Content-type"] = "application/json"
        default:
            break
        }
        return headers
    }
}
