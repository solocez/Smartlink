import Foundation

final class LoginResponseFactory {
    init() {}

    func dematerialiseLoginResponse(from: Data) -> LoginResponseEntity? {
        do {
            let result = try JSONDecoder().decode(LoginResponseEntity.self, from: from)
            return result
        } catch {
            return nil
        }
    }
}
