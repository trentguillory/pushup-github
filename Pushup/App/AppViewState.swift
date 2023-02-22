import Foundation
import OctoKit

// MARK: - AppViewLoadingState

enum AppViewState {
    case login(error: AppViewError?)
    case loading
    case loadedHome(viewModel: HomeViewModel)
}

// MARK: - AppViewError

enum AppViewError: Error {
    case unknownError(Error)
    case oAuthLinkCreationFailed
}
