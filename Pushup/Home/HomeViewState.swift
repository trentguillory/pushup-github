import Foundation
import OctoKit

enum HomeViewState {
    case loaded([RepositoryModel])
    case loading
    case error(Error)
}
