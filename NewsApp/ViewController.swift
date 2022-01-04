//
//  ViewController.swift
//  NewsApp
//
//  Created by OSU App Center on 6/2/21.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var articles = [Article]()
    
    let model = DataModel()
    
    var article:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        model.getArticles()
        
        
    }
    
    
}


extension ViewController: DataProtocol, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! CustomTableViewCell
        
        //reset the setting of view cell to default
        cell.tableImage.image = nil
        cell.content.text = ""
        
        cell.content.alpha = 0
        cell.tableImage.alpha = 0
        
        article = self.articles[indexPath.row]
        cell.content.text = article!.title
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            cell.content.alpha = 1
        }, completion: nil)
        
        
        let urlString = article!.urlToImage
        
        if urlString != nil {
            if let data = cacheManager.retrieveArticle(urlString!) {
                
                if self.article!.urlToImage == urlString{
                    
                    
                    DispatchQueue.main.async {
                        cell.tableImage.image = UIImage(data: data)
                        
                        UIView.animate(withDuration: 3.0, delay: 0, options: .curveEaseOut, animations: {
                            cell.imageView?.alpha = 1
                        }, completion: nil)
                        
                        
                    }
                }
                
            }
            
            else{
                if let url = URL(string: urlString!){
                    
                    let session = URLSession.shared
                    
                    let dataTask = session.dataTask(with: url) { (data, response, error) in
                        if data != nil && error == nil {
                            
                            cacheManager.storeArticle(urlString!, data!)
                            
                            if self.article!.urlToImage == urlString{
                                DispatchQueue.main.async {
                                    cell.tableImage.image = UIImage(data: data!)
                                    
                                    UIView.animate(withDuration: 3.0, delay: 0, options: .curveEaseOut, animations: {
                                        cell.tableImage.alpha = 1
                                    }, completion: nil)
                                }
                            }
                            
                        }
                    }
                    dataTask.resume()
                }
                else{
                    cell.tableImage.alpha = 1}
                
            }
            
            
        }
        cell.tableImage.alpha = 1
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // it will call prepare segue
        performSegue(withIdentifier: "goToWeb", sender: self)
        
        
        
    }
    
    //this function fires every time a sugue happens, like tapping a cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //detect which article the user selected
        let indexPath = tableView.indexPathForSelectedRow
        guard indexPath != nil else {return}
        
        let article = articles[indexPath!.row]
        
        //important here
        //where the segue is headed to
        let detailVC = segue.destination as! DetailViewController
        
        detailVC.articleUrl = article.url
        
        
    }
    
    
    
    func retrieve() {
        self.articles = model.articles!
        tableView.reloadData()
    }
    
}
