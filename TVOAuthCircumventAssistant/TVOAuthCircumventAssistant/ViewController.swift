//
//  ViewController.swift
//  TVOAuthCircumventAssistant
//
//  Created by Garrett Richards on 1/2/16.
//  Copyright © 2016 Garrett Richards. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var URLLabel: UILabel!
    
    private var assistant: TVOAuthCircumventAssistant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!unitTestsRunning()) {
            configureAssistant()
        }
    }
    
    private func configureAssistant() {
        
        var configuration = TVOAuthCircumventAssistantConfiguration()

        //  This URL below is contrived to illustrate how to use this example, usually the response would give you a tvToken
        //  you could use with your app
        let url:String = "http://bit.ly/123456".stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!
        configuration.tvTokenFetchURL = "https://httpbin.org/response-headers?tvToken=123456&url=\(url)"
        configuration.retrieveAuthenticationInfoURL = "https://httpbin.org/response-headers?accessToken=abcdefghijk123456&userid=1"

        assistant = TVOAuthCircumventAssistant(configuration: configuration)
        
        assistant?.fetchTVToken({ [weak self] (response, error) -> Void in
            if let response = response {
                self?.URLLabel.text = response["url"] as? String
                if let tvToken = response["tvToken"] {
                    //  This URL is contrived again to illustrate use of the response from this request to check
                    //  that the user has successfully authenticated on phone
                    self?.assistant?.configuration.retrieveAuthenticationInfoURL = (self?.assistant?.configuration.retrieveAuthenticationInfoURL)! + "&tvToken=\(tvToken)"
                }
            }
            else if let error = error as? NSError {
                self?.URLLabel.text = error.localizedDescription
                print("error: \(error.localizedDescription)")
            }
        })
    }
    
    private func retrieveOAuthAuthenticationInfo() {
        assistant?.retrieveAuthenticationInfoURL({ (response, error) -> Void in
            if let response = response {
                print("OAuth authentication info: \(response)")
            } else if let error = error as? NSError {
                print("error: \(error.localizedDescription)")
            }
        })
    }

    @IBAction func actionDoneAuthenticatingWithOAuthProvider(sender: UIButton) {
        retrieveOAuthAuthenticationInfo()
    }
    
    private func unitTestsRunning() -> Bool {
        let injectBundlePath:NSString? = NSProcessInfo.processInfo().environment["XCInjectBundle"]
        if(injectBundlePath?.pathExtension == "xctest") {
            return true
        }
        return false

    }
}

