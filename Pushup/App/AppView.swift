import OctoKit
import SwiftUI

// MARK: - ContentView

struct AppView: View {
    // MARK: Internal

    @StateObject var viewModel = AppViewModel()

    var body: some View {
        VStack {
            switch viewModel.loadingState {
            case let .loadedHome(homeViewModel): HomeView(viewModel: homeViewModel)
            case let .login(error: error): loginView(error: error)
            case .loading: ProgressView()
            }
        }
        .padding()
        .onOpenURL(perform: { url in
            viewModel.didReceiveGithubRedirect(url)
        })
    }

    // MARK: Private

    // TODO: Move to own file
    private func loginView(error: AppViewError?) -> some View {
        VStack {
            Button("Login with Github", action: viewModel.didTapLogin)

            VStack {
                if error != nil {
                    Text("An error occurred.")
                }
            }
            .frame(height: 30)
        }
    }
}
