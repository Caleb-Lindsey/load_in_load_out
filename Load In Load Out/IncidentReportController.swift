//
//  IncidentReportController.swift
//  Load In Load Out
//
//  Created by Caleb Lindsey on 10/19/17.
//  Copyright © 2017 KlubCo. All rights reserved.
//

import UIKit
import WebKit

class IncidentReportController : CustomViewController, WKNavigationDelegate {
    
    let webView : WKWebView = {
        let view = WKWebView()
        return view
    }()
    
    let activityWheel : UIActivityIndicatorView = {
        let wheel = UIActivityIndicatorView()
        wheel.activityIndicatorViewStyle = .gray
        wheel.hidesWhenStopped = true
        return wheel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        // Do any additional setup after loading the view, typically from a nib.        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        let website = "https://atnewlife.org/facility-maintenance/"
        let url = NSURL(string: website)
        let request = NSURLRequest(url: url! as URL)
        
        webView.frame = self.view.frame
        
        activityWheel.center = self.view.center
        view.addSubview(activityWheel)
        
        webView.navigationDelegate = self
        webView.load(request as URLRequest)
        self.view.addSubview(webView)
        self.view.sendSubview(toBack: webView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Loading...")
        activityWheel.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Load complete.")
        activityWheel.stopAnimating()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    
    
}



