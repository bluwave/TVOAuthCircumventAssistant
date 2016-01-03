//
//  TVOAuthCircumventAssistant.swift
//  TVOAuthCircumventAssistant
//
//  Created by Garrett Richards on 1/2/16.
//  Copyright © 2016 Garrett Richards. All rights reserved.
//

import Foundation
import Alamofire

public struct TVOAuthCircumventAssistantConfiguration {
    var tvTokenFetchURL:String?
    var retrieveAuthenticationInfoURL: String?
}

public let TVOAuthCircumventAssistantDomain:String = "com.acme.TVOAuthCircumventAssistant"
public typealias TVOAuthCircumventAssistantResponse = ([String:AnyObject]?,ErrorType?) -> Void

public class TVOAuthCircumventAssistant {
    
    public var configuration = TVOAuthCircumventAssistantConfiguration()
    private var networkManager: Manager?
    
    public init() {
        setupDefaultNetworkManager()
    }

    public init(configuration:TVOAuthCircumventAssistantConfiguration) {
        self.configuration = configuration
        setupDefaultNetworkManager()
    }

    internal init(networkManager:Alamofire.Manager) {
        self.networkManager = networkManager
    }

    private func setupDefaultNetworkManager() {
        self.networkManager = Alamofire.Manager.sharedInstance
    }
    
    public func fetchTVToken(handler:TVOAuthCircumventAssistantResponse) {
        self.request(configuration.tvTokenFetchURL, handler: handler)
    }
    
    public func retrieveAuthenticationInfoURL(handler: TVOAuthCircumventAssistantResponse) {
        self.request(configuration.retrieveAuthenticationInfoURL, handler: handler)
    }

    private func request(URL:String?, handler:TVOAuthCircumventAssistantResponse) {
        guard let URL = URL else {
            let error = NSError(domain: TVOAuthCircumventAssistantDomain, code: 100, userInfo: nil)
            handler(nil, error)
            return
        }

        networkManager?.request(.GET, URL, parameters: nil).responseJSON { response in
            switch response.result {
            case .Success(let data):
                handler(data as? [String:AnyObject], nil)
            case .Failure(let error):
                handler(nil, error)
            }
        }
    }
}