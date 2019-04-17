//
//  BaseApi.swift
//  MoyaDemo
//
//  Created by tenltrs on 2019/4/16.
//  Copyright © 2019 Tenltrs. All rights reserved.
//

import Moya
import SwiftyJSON


/// api缓存类型
///
/// - cache: 缓存
/// - none: 不缓存
enum ApiCacheType {
    case cache
    case none
}

protocol BaseApi: TargetType {
    
    /// 接口是否需要缓存
    var cacheType: ApiCacheType { get }
}


extension BaseApi {
    
    var baseURL: URL {
        return URL(string: "http://localhost:8020/api")!
    }
}

extension TargetType {
    
    
    /// 请求 url
    var url: String {
        
        return baseURL.absoluteString + path
    }
    
    
    /// 缓存key
    var cacheKey : String {
        if parameters.count > 0 {
            let paramStr = parameters.keys.sorted().map {
                if let v = parameters[$0] {
                    return $0 + "=" + String(describing: v)
                } else {
                    return ""
                }
                }.joined(separator: "&")
            return baseURL.absoluteString + path + "?" + paramStr
        } else {
            return baseURL.absoluteString + path
        }
    }
    
    /// 请求参数
    var parameters: [String: Any] {
        switch task {
        case .requestParameters(parameters: let param, _):
            return param
        default:
            return [String: Any]()
        }
    }
}

