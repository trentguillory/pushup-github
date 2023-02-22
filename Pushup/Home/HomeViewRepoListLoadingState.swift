import Foundation
import OctoKit

enum HomeViewRepoListLoadingState {
    case loaded([RepositoryModel])
    case loading
    case error(Error)
}
