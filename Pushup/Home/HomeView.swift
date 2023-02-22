import Foundation
import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State var headerHeight: CGFloat = 0

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                VStack {
                    Spacer().frame(height: headerHeight)

                    switch viewModel.repoListLoadingState {
                    case let .loaded(repos): RepoListView(repositories: repos)
                    case .loading: ProgressView()
                    case let .error(error): Text(error.localizedDescription)
                    }
                }
                .padding([.leading, .trailing])
                .frame(maxWidth: .infinity)
            }

            ProfileHeaderView(viewModel: viewModel.profileHeaderViewModel)
                .overlay(GeometryReader { geometry in
                    Color.clear.onAppear {
                        self.headerHeight = geometry.frame(in: .global).height
                    }
                })
        }
    }
}
