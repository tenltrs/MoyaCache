//
//  AjaxResult.swift
//  MoyaDemo
//
//  Created by tenltrs on 2019/4/16.
//  Copyright © 2019 Tenltrs. All rights reserved.
//

import UIKit
import ObjectMapper

class AjaxResult: Mappable {
    
    var code : String?
    
    var msg : String?
    
    var data : Any?
    
    var success : Bool = false
    
    /// 原始字典数据
    var responseData : String?
    
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
        data <- map["data"]
    }
    
}
