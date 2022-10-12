import Foundation

enum Constants {
    enum Host {
        static let prod = "http://registration.securenettech.com/registration.php"
        static let preprod = "http://registration.securenettech.com/registration.php"
    }
    static let innerElementsSpacing = 8.0
    static let topBottomMinimalPadding = 16.0
    static let textFieldHeight = 60.0
}


protocol AppConfigurable {
    var host: String { get }
}

final class AppConfiguration: AppConfigurable {

    static var shared = AppConfiguration(host: Constants.Host.preprod)

    let host: String

    private init(host: String) {
        self.host = host
    }
}
