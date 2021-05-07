//
//  ViewController.swift
//  netflix
//
//  Created by Rune Warhuus on 04/05/2021.
//

import Cocoa
import WebKit

class WebView: WKWebView {
    override var isOpaque: Bool {
        return false
    }
    
    override func interpretKeyEvents(_ eventArray: [NSEvent]) {
        if (eventArray[0].modifierFlags.contains(.command) && eventArray[0].keyCode == 3) {
            window?.toggleFullScreen(self)
        }
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
        
        NSAnimationContext.runAnimationGroup({ context in
            context.allowsImplicitAnimation = true
            context.duration = 1
            webView.animator().alphaValue = 1
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        guard let url = URL(string: "https://netflix.com/") else {return}
        let request = URLRequest(url: url)
        webView.isHidden = true
        webView.alphaValue = 0
        webView.navigationDelegate = self
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
