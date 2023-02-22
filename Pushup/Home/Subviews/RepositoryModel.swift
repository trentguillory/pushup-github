import Foundation
import OctoKit

struct RepositoryModel: Identifiable {
    // MARK: Lifecycle

    init(repository: Repository, dateFormatter: DateComponentsFormatter) {
        id = repository.id
        name = repository.name ?? ""
        stargazers = String(repository.stargazersCount ?? 0)
        if let lastPush = repository.lastPush,
           let formattedDate = dateFormatter.string(from: lastPush, to: Date()) {
            self.lastPush = "\(formattedDate) ago"
        } else {
            lastPush = ""
        }
    }

    // MARK: Internal

    let id: Int
    let name: String
    let stargazers: String
    let lastPush: String
}
