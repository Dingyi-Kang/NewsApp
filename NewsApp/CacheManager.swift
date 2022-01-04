//
//  CacheManager.swift
//  NewsApp
//
//  Created by OSU App Center on 6/3/21.
//

import Foundation


class cacheManager {
    
    static var dataDictionary = [String:Data]()
    
    
    static func storeArticle(_ urlString:String, _ data:Data){
        
        dataDictionary[urlString] = data
        
    }
    
    static func retrieveArticle(_ urlString:String) -> Data? {
        
        return dataDictionary[urlString]
        
    }
    
    
}
