import Foundation
import OctoKit

class NetworkClient {
    // MARK: Lifecycle

    init(config: NetworkConfigurationProtocol = NetworkConfiguration.default) {
        configuration = config
    }

    // MARK: Internal

    var isAuthenticated: Bool {
        return octokitClient != nil
    }

    func authenticate() -> URL? {
        return authConfig.authenticate()
    }

    func handleRedirectUrl(_ url: URL, completion: @escaping (_ success: Bool) -> Void) {
        authConfig.handleOpenURL(url: url) { config in
            self.octokitClient = Octokit(config)
            completion(true)
        }
    }

    func loadUser() async throws -> User {
        guard let octokitClient else { throw NetworkError.unauthenticated }

        return try await octokitClient.me()
    }
    
    func loadRepositories(page: Int, perPage: Int = 100) async throws -> [Repository] {
        guard let octokitClient else { throw NetworkError.unauthenticated }
        
        return try await octokitClient.repositories(page: String(page), perPage: String(perPage))
    }

    // MARK: Private

    private var octokitClient: Octokit? = .none
    private let configuration: NetworkConfigurationProtocol

    // TODO: Move scopes to `NetworkOptions` struct
    private var authConfig: OAuthConfiguration {
        .init(
            token: configuration.githubAppClientId,
            secret: configuration.githubAppSecret,
            scopes: ["repo", "read:org", "user"]
        )
    }
}
