import Foundation

final class LoginResponseFactory {
    init() {}

    func dematerialiseLoginResponse(from: Data) -> LoginResponseEntity? {
        do {
            NSLog("DECODING: \(String(decoding: from, as: UTF8.self))")
            let result = try JSONDecoder().decode(LoginResponseEntity.self, from: from)
            return result
        } catch {
            return nil
        }
    }
}
