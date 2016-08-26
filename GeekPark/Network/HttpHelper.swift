//
//  HttpHelper.swift
//  GeekPark
//
//  Created by lan on 16/8/25.
//  Copyright © 2016年 lan. All rights reserved.
//

import Cocoa
import Alamofire



class HttpHelper: NSObject {
    let url = "http://www.geekpark.net/"
    
    func getNews() {
        Alamofire.request(.GET, url).responseData { response in
            print(response.request)
            print(response.response)
            print(response.data)
        }
    }

}
