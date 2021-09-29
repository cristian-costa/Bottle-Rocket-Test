//
//  InternetViewController.swift
//  BottleRocketTest
//
//  Created by Cristian Costa on 27/09/2021.
//

import UIKit
import WebKit

class InternetViewController: UIViewController, WKNavigationDelegate {
    private let webView: WKWebView = {
        let webView = WKWebView()
        let url = URL(string: "https://www.bottlerocketstudios.com/")
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.load(URLRequest(url: url!))
        return webView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        view.addSubview(webView)
        addConstraints()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func refreshBtnPressed(_ sender: Any) {
        webView.reload()
    }
    
    func addConstraints() {
        var constraints = [NSLayoutConstraint]()

        //Add
        constraints.append(webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))

        //Activate
        NSLayoutConstraint.activate(constraints)
    }
}

