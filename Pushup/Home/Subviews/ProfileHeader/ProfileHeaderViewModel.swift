import Foundation
import OctoKit

class ProfileHeaderViewModel: ObservableObject {
    // MARK: Lifecycle

    init(user: User) {
        username = user.login ?? "unknown_username"
        userImage = URL(string: user.avatarURL ?? "")
        followers = String(user.numberOfFollowers ?? 0)
        following = String(user.numberOfFollowing ?? 0)
        stars = ""
    }

    // MARK: Internal

    let username: String
    let userImage: URL?
    let followers: String
    let following: String
    @Published var stars: String

    func setStarred(totalStars: Int) {
        stars = String(totalStars)
    }
}
