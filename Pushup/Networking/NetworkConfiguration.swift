import Foundation

// MARK: - NetworkConfigurationProtocol

protocol NetworkConfigurationProtocol {
    var githubAppClientId: String { get }
    var githubAppSecret: String { get }
}

// MARK: - NetworkConfiguration

struct NetworkConfiguration: NetworkConfigurationProtocol {
    let githubAppClientId: String
    let githubAppSecret: String
}
