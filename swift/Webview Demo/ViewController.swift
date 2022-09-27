//
//  ViewController.swift
//  Webview Demo
//
//  Created by Ashish Pisey on 13/09/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.txtView.delegate = self
    }

    @IBAction func openWebview(_ sender: UIButton) {
        let webviewVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewVC") as! WebViewVC
        if let urlPath = txtView.text,
           let _ = URL(string: urlPath) {
            webviewVC.url = urlPath
        }
        self.navigationController?.pushViewController(webviewVC, animated: true)
    }    
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }
}

