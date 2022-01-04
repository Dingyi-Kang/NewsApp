//
//  File.swift
//  NewsApp
//
//  Created by OSU App Center on 6/2/21.
//

import Foundation


struct Article: Decodable {
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    
}
