//
//  WebViewVC.swift
//  Webview Demo
//
//  Created by Ashish Pisey on 13/09/22.
//

/*
 In Javascript do this:-
 
 var messageObj = {'status':'call_end', 'message':'Your hearing has ended'};
 window.webkit.messageHandlers.keyName.postMessage(messageObj)
 
 */

import UIKit
import WebKit

class WebViewVC: UIViewController, WKScriptMessageHandler {
    
    var url: String? = "http://localhost:3001"
    var acsToken = "1234"
    var hearingId = "abcd"
    
    @IBOutlet weak var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.navigationDelegate = self
        
        let contentController = self.webview.configuration.userContentController
        contentController.add(self, name: "keyName")
        contentController.add(self, name:"getHearingInfo")
        
        // Do any additional setup after loading the view.
        if let urlpath = url,
           let _ = URL.init(string: urlpath) {
            
//            sendDataToJavascript()
            
            DispatchQueue.main.async {
                // main thread ui refresh
                self.webview.load(urlpath)
            }
        }
    }
    
    // send data to javascript
    func sendDataToJavascript() {
        let js = "var event = new CustomEvent('customevent', { detail: { data: '\(acsToken)'}}); window.dispatchEvent(event);"
        self.webview.evaluateJavaScript(js) { (result, error) in
            if error == nil {
                debugPrint("sent to javascript successfully")
                debugPrint(result)
            }else {
                debugPrint(error?.localizedDescription ?? "Error occurred")
            }
        }
    }
    
    // receive data from javascript
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        DispatchQueue.main.async {
            if let messageObj = message.body as? [String:Any],
               let status = messageObj["status"] as? String,
               let message = messageObj["message"] as? String,
               status == "call_end" {
                self.sendDataToJavascript()
                self.showAlert(title: "Hearing ended", message: message.description)
            } else if let messageObj = message.body as? [String:Any],
                      let status = messageObj["status"] as? String,
                      status == "get_hearing_info" {
                self.sendDataToJavascript()
            }
            
            else {
                print("Invalid message obj type")
            }
        }
    }
    
    func showAlert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { action in
            if message == "call_end" {
                print("Go back to previous page")
                //self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// just for debugging not needed otherwise

extension WebViewVC:WKNavigationDelegate,WKUIDelegate {
    // webview start navigation
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        
        if let url = webView.url?.absoluteString{
            print("url = \(url)")
        }
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("redirecting to", webview.url ?? "")
    }
    
    // webview loading completed
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.sendDataToJavascript()
//        self.showAlert(title: "Webview loaded", message: "")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
}
