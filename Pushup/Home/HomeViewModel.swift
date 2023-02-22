import Foundation
import OctoKit

// MARK: - HomeViewModel

class HomeViewModel: ObservableObject {
    // MARK: Lifecycle

    init(user: User, networkClient: NetworkClient) {
        profileHeaderViewModel = .init(user: user)
        self.networkClient = networkClient

        let dateFormatter = DateComponentsFormatter()
        dateFormatter.unitsStyle = .full
        dateFormatter.maximumUnitCount = 1
        dateFormatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]
        dateFormatter.calendar = Calendar.current
        dateFormatter.calendar?.locale = Locale(identifier: "en_US")

        self.dateFormatter = dateFormatter

        loadUserRepositories()
    }

    // MARK: Internal

    @Published var profileHeaderViewModel: ProfileHeaderViewModel
    @Published var repoListLoadingState: HomeViewRepoListLoadingState = .loading

    // MARK: Private

    private let dateFormatter: DateComponentsFormatter
    private let networkClient: NetworkClient

    private func loadUserRepositories() {
        Task { @MainActor in
            self.repoListLoadingState = .loading
            do {
                let repos = try await self.networkClient.loadRepositories(page: 1)

                // Update list loading state
                setRepoLoadingListState(repositories: repos)

                // Update profile header
                setProfileHeaderStarCount(repositories: repos)
            } catch {
                self.repoListLoadingState = .error(error)
            }
        }
    }

    private func setRepoLoadingListState(repositories: [Repository]) {
        let repoModels = repositories
            .sorted(by: { a, b in
                a.stargazersCount ?? 0 > b.stargazersCount ?? 0
            })
            .map { RepositoryModel(repository: $0, dateFormatter: self.dateFormatter) }
        repoListLoadingState = .loaded(repoModels)
    }

    private func setProfileHeaderStarCount(repositories: [Repository]) {
        let totalStars = repositories.reduce(0) { $0 + ($1.stargazersCount ?? 0) }
        profileHeaderViewModel.setStarred(totalStars: totalStars)
    }
}
