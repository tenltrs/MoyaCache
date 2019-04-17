//
//  RequestManager.swift
//  MoyaDemo
//
//  Created by tenltrs on 2019/4/16.
//  Copyright © 2019 Tenltrs. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import ObjectMapper
import RxSwift

class RequestManager: NSObject {

    static let homeApi = NetWorking<HomeApi>()

    
}

extension MoyaProviderType {
    
    
    /// 进行Rx网络请求
    ///
    /// - Parameters:
    ///   - token: 请求token
    ///   - callbackQueue: 进程
    ///   - progress: 进度
    /// - Returns: rx service
    func rxRequest(_ token: Target, callbackQueue: DispatchQueue? = nil, progress: Moya.ProgressBlock? = nil) -> Observable<AjaxResult>{
    
        return Observable.create { [weak self] observer in
            
            /// 判断是否需要缓存
            if let baseApi = token as? BaseApi{
               self?.getCacheAction(baseApi, observer: observer)
            }
            
            let cancellableToken = self?.request(token, callbackQueue: callbackQueue, progress: progress) { (result) in
                
                switch result {
                case .success(let value):

                    if let res = self?.getResult(data: value.data) {
                        observer.onNext(res)
                        /// 判断是否需要缓存
                        if let baseApi = token as? BaseApi {
                            self?.setCacheAction(baseApi, data: value.data)
                        }
                    }
 
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    
    /// 获取网络缓存
    ///
    /// - Parameters:
    ///   - token: api token
    ///   - observer: rx service
    fileprivate func getCacheAction(_ token: BaseApi, observer: AnyObserver<AjaxResult>) {
        guard token.cacheType != .none else { return }
        // 先读取缓存内容，有则发出一个信号（onNext），没有则跳过
        NSCacheTool.shared.netWork?.async.object(forKey: token.cacheKey, completion: { [weak self] (result) in
            
            guard let ws = self else { return }
            
            switch result {
            case .value(let value):
                if let res = ws.getResult(data: value){
                    observer.onNext(res)
                }
            case .error(let error):
                print("读取缓存失败 \(error.localizedDescription)")
            }
        })
    }
    
    /// 存入网络缓存
    ///
    /// - Parameters:
    ///   - token: api token
    ///   - data: 存储数据data
    fileprivate func setCacheAction(_ token: BaseApi, data: Data){
        
        guard token.cacheType != .none else { return }
        
        NSCacheTool.shared.netWork?.async.setObject(data, forKey: token.cacheKey, completion: { (result) in
            switch result {
            case .value( _):
                print("缓存成功")
            default:
                print("缓存失败")
            }
        })
    }
    
    
    /// 将data生成AjaxResult对象
    ///
    /// - Parameter data: 二进制数据
    /// - Returns: 返回
    fileprivate func getResult(data: Data) -> AjaxResult? {
        
        do{
            let json = try JSON.init(data: data)
            if let data = json.rawValue as? [String : Any], let res = AjaxResult.init(JSON: data) {
                res.success = ("0" == res.code)
                res.responseData = json.rawString()
                return res
            }
        } catch {
            // 解析失败
            return nil
        }
        
        return nil
    }
}
