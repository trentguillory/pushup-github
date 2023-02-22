import Foundation

// MARK: - NetworkConfigurationProtocol

protocol NetworkConfigurationProtocol {
    var githubAppClientId: String { get }
    var githubAppSecret: String { get }
}

// MARK: - NetworkConfiguration

struct NetworkConfiguration: NetworkConfigurationProtocol {
    static let `default`: NetworkConfiguration = {
        guard let bundleInfo = Bundle.main.infoDictionary,
              let githubAppClientId = bundleInfo["GITHUB_APP_CLIENT_ID"] as? String,
              let githubAppSecret = bundleInfo["GITHUB_APP_SECRET"] as? String
        else {
            fatalError("Failed to initialize NetworkConfiguration with Config.xcconfig")
        }

        return NetworkConfiguration(githubAppClientId: githubAppClientId, githubAppSecret: githubAppSecret)
    }()

    let githubAppClientId: String
    let githubAppSecret: String
}
