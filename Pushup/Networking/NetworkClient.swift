//
//  NetworkClient.swift
//  Pushup
//
//  Created by Trent Guillory on 2/22/23.
//

import Foundation

class NetworkClient {
    
    
    init(config: NetworkConfigurationProtocol) {
        self.configuration = config
    }
    
    private let configuration: NetworkConfigurationProtocol
}
