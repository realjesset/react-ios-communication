//
//  Extensions.swift
//  Webview Demo
//
//  Created by Ashish Pisey on 13/09/22.
//

import Foundation
import WebKit

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}

