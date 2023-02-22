import Foundation
import OctoKit
import UIKit

class AppViewModel: ObservableObject {
    // MARK: Lifecycle

    init() {
        getNetworkCredentials()
    }

    // MARK: Internal

    func didReceiveGithubRedirect(_ url: URL) {
        config.handleOpenURL(url: url) { _ in
        }
    }

    func didTapLogin() {
        guard let loginUrl = config.authenticate() else { return }
        UIApplication.shared.open(loginUrl)
    }

    func loadCurrentUser(config: TokenConfiguration) {
        Octokit(config).me { response in
            switch response {
            case let .success(user):
                print(user.login)
            case let .failure(error):
                print(error)
            }
        }
    }

    func loadStars(config: TokenConfiguration) {
        Octokit(config).myStars { response in
            switch response {
            case let .success(stars):
                print(stars)
            case let .failure(error):
                print(error)
            }
        }
    }

    // MARK: Private

    private var config: OAuthConfiguration {
        let credentials = getNetworkCredentials()

        return .init(
            token: credentials.githubAppClientId,
            secret: credentials.githubAppSecret,
            scopes: ["repo", "read:org", "read:user"])
    }

    private func getNetworkCredentials() -> NetworkConfigurationProtocol {
        if let bundleInfo = Bundle.main.infoDictionary {
            let githubAppClientId = bundleInfo["GITHUB_APP_CLIENT_ID"] as? String ?? "no id"
            print("id: \(githubAppClientId)")
            let githubAppSecret = bundleInfo["GITHUB_APP_SECRET"] as? String ?? "no secret"
            print("secret: \(githubAppSecret)")

            return NetworkConfiguration(githubAppClientId: githubAppClientId, githubAppSecret: githubAppSecret)
        } else {
            return NetworkConfiguration(githubAppClientId: "", githubAppSecret: "")
        }
    }
}
