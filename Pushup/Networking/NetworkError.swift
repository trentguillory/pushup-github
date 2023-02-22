import Foundation

enum NetworkError: Error {
    case unauthenticated, failedToLoad(Error)
}
