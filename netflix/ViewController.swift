//
//  ViewController.swift
//  netflix
//
//  Created by Rune Warhuus on 04/05/2021.
//

import Cocoa
import WebKit

class WebView: WKWebView {
    override func becomeFirstResponder() -> Bool {
        return false
    }
    
    override func resignFirstResponder() -> Bool {
        return true
    }
}

class ViewController: NSViewController {
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WebView(frame: .zero, configuration: configuration)
        return webView
    }()
    
    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        guard let url = URL(string: "https://netflix.com/") else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        webView.frame = view.bounds
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
