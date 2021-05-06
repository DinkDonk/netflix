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
    
    override var isOpaque: Bool {
        return false
    }
}

class ViewController: NSViewController, WKNavigationDelegate {
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webView = WebView(frame: .zero, configuration: configuration)
        
        return webView
    }()
    
    func webView(_ webView: WKWebView, didFinish: WKNavigation!) {
        webView.isHidden = false
    }

    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func keyDown(with event: NSEvent) {
        if (event.modifierFlags.contains(.command) && event.keyCode == 3) {
            return
        }
        
        webView.keyDown(with: event)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        guard let url = URL(string: "https://netflix.com/") else {return}
        let request = URLRequest(url: url)
        webView.isHidden = true
        webView.navigationDelegate = self
        webView.load(request)
        
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            self.keyDown(with: $0)
            return $0
        }
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
