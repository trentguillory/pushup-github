import Foundation
import OctoKit
import UIKit

class AppViewModel: ObservableObject {
    // MARK: Lifecycle

    init(networkClient: NetworkClient = .init()) {
        self.networkClient = networkClient
    }

    // MARK: Internal

    @Published var loadingState: AppViewState = .login(error: .none)

    func didReceiveGithubRedirect(_ url: URL) {
        networkClient.handleRedirectUrl(url) { _ in
            self.loadUser()
        }
    }

    func didTapLogin() {
        guard let loginUrl = networkClient.authenticate() else {
            loadingState = .login(error: .oAuthLinkCreationFailed)
            return
        }

        UIApplication.shared.open(loginUrl)
    }

    // MARK: Private

    private let networkClient: NetworkClient

    private func loadUser() {
        Task { @MainActor in
            self.loadingState = .loading

            do {
                let user = try await networkClient.loadUser()
                let homeViewModel = HomeViewModel(user: user, networkClient: networkClient)
                self.loadingState = .loadedHome(viewModel: homeViewModel)
            } catch {
                self.loadingState = .login(error: .unknownError(error))
            }
        }
    }
}
