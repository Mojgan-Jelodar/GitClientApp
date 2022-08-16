//
//  HeaderPlugin.swift
//  GitClient
//
//  Created by Mozhgan on 9/25/21.
//

import Foundation
import Moya

struct  HeaderPlugin : PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var currentRequest = request
        currentRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return currentRequest
    }
}
