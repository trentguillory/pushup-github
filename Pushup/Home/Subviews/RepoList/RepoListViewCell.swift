import OctoKit
import SwiftUI

// MARK: - RepoListViewCell

struct RepoListViewCell: View {
    let repository: RepositoryModel

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "book.closed")
                Text(repository.name)
                    .fontWeight(.semibold)
                Spacer()
            }
            HStack(spacing: 16) {
                Label(repository.stargazers, systemImage: "star")
                    .font(.footnote)
                Label(repository.lastPush, systemImage: "calendar")
                    .font(.footnote)
                Spacer()
            }
        }
        .padding(8)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(.gray.opacity(0.2), lineWidth: 1)
        )
    }
}
