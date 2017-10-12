//
//  HttpHelper.swift
//  GeekPark
//
//  Created by lan on 16/8/25.
//  Modified by Xiaopeng
//  Copyright © 2016年 lan. All rights reserved.
//

import Cocoa
import Alamofire
import SwiftyJSON

class HttpHelper: NSObject {
    let url = "http://main_test.geekpark.net/api/v1/?page=1"
    
    func getNews(_ handle: @escaping (_ models: [GPModel]) -> ()) {
        
        Alamofire.request(url).validate().responseJSON { response in
            guard let value = response.result.value else { return }
            let json = JSON(value)
            guard let homepage_posts  = json["homepage_posts"].array else { return }
            var models = [GPModel]()
            for homepage_post in homepage_posts {
                guard let data  = homepage_post["data"].array else { return }
                for post in data {
                    
                    guard let title  = post["post"]["title"].string else { return }
                    guard let imgUrl  = post["post"]["cover_url"].string else { return }
                    guard let category  = post["post"]["column"]["title"].string else { return }
                    guard let published_timestamp  = post["post"]["published_timestamp"].int else { return }
                    guard let id  = post["post"]["id"].int else { return }
                    
                    let href = "http://www.geekpark.net/news/\(id)"
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

