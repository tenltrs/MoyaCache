//
//  Networking.swift
//  MoyaDemo
//
//  Created by tenltrs on 2019/4/16.
//  Copyright © 2019 Tenltrs. All rights reserved.
//

import Moya

final class NetWorking<Target: TargetType>: MoyaProvider<Target> {

    init(plugins: [PluginType] = []) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 10
        
//        var plugins = plugins
//        plugins.append(ResultPlugin())
        
        let manager = Manager(configuration: configuration)
        super.init(manager: manager, plugins: plugins)
    }
}
