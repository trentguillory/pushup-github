import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    AsyncImage(url: viewModel.userImage) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 24, height: 24)
                    .background(Color.gray)
                    .clipShape(Circle())

                    Text(viewModel.username)

                    Spacer()
                }

                switch viewModel.loadingState {
                case let .loaded(repos): RepoListView(repositories: repos)
                case .loading: ProgressView()
                case let .error(error): Text(error.localizedDescription)
                }
            }
        }
    }
}
