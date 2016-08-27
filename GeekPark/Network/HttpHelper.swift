//
//  HttpHelper.swift
//  GeekPark
//
//  Created by lan on 16/8/25.
//  Copyright © 2016年 lan. All rights reserved.
//

import Cocoa
import Alamofire
import Fuzi

class HttpHelper: NSObject {
    let url = "http://www.geekpark.net/"

    func getNews() {
        Alamofire.request(.GET, url).responseString { response in
            let html = response.result.value
            
            do {
                var models = [GPModel]()
                let doc = try HTMLDocument(string: html!, encoding: NSUTF8StringEncoding)

                for article in doc.xpath("//article[@class='article-item']") {
                    var title = String()
                    var imgUrl = String()
                    
                    if let a = article.firstChild(xpath:".//a/div/img") {
                        imgUrl = a["data-src"]!
                    }
                    
                    if let d = article.firstChild(xpath:".//div/div/a[2]") {
                        title = d["data-event-label"]!
                    }
                    
                    let model = GPModel(title: title, imgUrl: imgUrl)
                    
                    models.append(model)
                }
                print(models.count)
            
            }catch let error {
                print(error)
            }
        }
    }
}
