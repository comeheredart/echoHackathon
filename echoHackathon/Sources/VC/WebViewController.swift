//
//  WebViewController.swift
//  echoHackathon
//
//  Created by JEN Lee on 2021/06/02.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    var urlString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false

        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        webView.load(request)

    }

}
