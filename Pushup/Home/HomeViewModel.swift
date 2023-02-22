import Foundation
import OctoKit

class HomeViewModel: ObservableObject {
    // MARK: Lifecycle

    init(user: User, networkClient: NetworkClient) {
        username = user.login ?? ""
        userImage = URL(string: user.avatarURL ?? "")
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
    
    @Published var loadingState: HomeViewState = .loading

    // MARK: Internal

    var username: String
    var userImage: URL?
    
    private let dateFormatter: DateComponentsFormatter
    
    private func loadUserRepositories() {
        Task { @MainActor in
            self.loadingState = .loading
            do {
                let repos = try await self.networkClient.loadRepositories(page: 1)
                let repoModels = repos
                    .sorted(by: { a, b in
                        a.stargazersCount ?? 0 > b.stargazersCount ?? 0
                    })
                    .map { RepositoryModel(repository: $0, dateFormatter: self.dateFormatter) }
                self.loadingState = .loaded(repoModels)
            } catch {
                self.loadingState = .error(error)
            }
        }
    }
    
    // MARK: Private

    private let networkClient: NetworkClient
}

extension Repository: Identifiable {}
