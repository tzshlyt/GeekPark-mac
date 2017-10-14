//
//  HttpHelper.swift
//  GeekPark
//
//  Created by lan on 16/8/25.
//  Copyright © 2016年 lan. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class HttpHelper: NSObject {
    let url = "http://main_test.geekpark.net/api/v1/?page=1"
    
    func getNews(_ handle: @escaping (_ models: [GPModel]) -> ()) {
        
        Alamofire.request(url, method: .get).responseJSON { response in
            switch response.result {
            case .failure(let error):
                print("获取接口数据出错",error)
            case .success:
                print("Load data success")
                
                var models = [GPModel]()
                if let value = response.result.value {
                    let json = JSON(value), results = json["homepage_posts"]
                    for result in results.arrayValue {
                        let datas = result["data"]
                        for data in datas.arrayValue {
                            
                            guard let title = data["post"]["title"].string else { return }
                            guard let imgUrl = data["post"]["cover_url"].string else { return }
                            guard let category  = data["post"]["column"]["title"].string else { return }
                            guard let published_timestamp  = data["post"]["published_timestamp"].int else { return }
                            guard let id = data["post"]["id"].int else { return }
                            let href  = "http://www.geekpark.net/news/\(id)"
                            
                            let timeInterval: TimeInterval = TimeInterval(published_timestamp)
                            let date = Date(timeIntervalSince1970: timeInterval)
                            let dformatter = DateFormatter()
                            dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            let time = dformatter.string(from: date)
                            
                            let model = GPModel(
                                title: title,
                                imgUrl: imgUrl,
                                category: category,
                                time: time,
                                href: href
                            )
                            models.append(model)
                        }
                    }
                    handle(models)
                }
            }
        }
        
    }
}
