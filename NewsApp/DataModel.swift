//
//  DataModel.swift
//  NewsApp
//
//  Created by OSU App Center on 6/2/21.
//

import Foundation

protocol DataProtocol {
    func retrieve()
}


class DataModel {
    
    var articles:[Article]?
    var delegate:DataProtocol?
    
    func getArticles(){
        
        //step 1
        let urlString =
            "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ff308ef9752a42d49e60d18ab558fa8a"
           
        //step 2
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
        
        //step 3
        let urlSession = URLSession.shared
        
        //step 4
        let dataTask = urlSession.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
                
                do {
                    
                    let news = try decoder.decode(NewsToday.self, from: data!)
                    self.articles = news.articles
                    
                    DispatchQueue.main.async {
                        self.delegate?.retrieve()
                    }
                    
                }
                catch {
                    print("Cannot fetch data")
                }//end of do catch
                
            } // end of if
        }//end of data task
        //step 5
        dataTask.resume()
        
        
    }// end of func article
    
    
    
}
