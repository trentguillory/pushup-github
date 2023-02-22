import OctoKit
import SwiftUI

struct RepoListView: View {
    var repositories: [RepositoryModel]

    var body: some View {
        ForEach(repositories) { repo in
            RepoListViewCell(repository: repo)
        }
    }
}
