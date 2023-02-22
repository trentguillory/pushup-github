import SwiftUI
import OctoKit

// MARK: - ContentView

struct AppView: View {
    
    @StateObject var viewModel = AppViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onOpenURL(perform: { url in
            viewModel.didReceiveGithubRedirect(url)
        })
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
    
    func loadFollowers(config: TokenConfiguration) {
        Octokit(config).myStars { response in
            switch response {
            case let .success(stars):
                print(stars)
            case let .failure(error):
                print(error)
            }
        }
    }
}
