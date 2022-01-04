//
//  DetailViewController.swift
//  NewsApp
//
//  Created by OSU App Center on 6/3/21.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var WebView: WKWebView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebView.navigationDelegate = self
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if articleUrl != nil {
            //translate url string into object
            let url = URL(string: articleUrl!)
            
            guard url != nil else {return}
            //create url request
            let request = URLRequest(url: url!)
            
            //load the request into webView
            WebView.load(request)
            indicator.alpha = 1
            indicator.startAnimating()
            
        }
        
    }


}

extension DetailViewController : WKNavigationDelegate {
        
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
        indicator.alpha = 0
    }
    
}


