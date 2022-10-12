import Foundation

enum Partner: String, Decodable {
    case cloud = "CLOUD"
    case slomins = "SLOMINS"
}

enum Environment: String, Decodable {
    case production = "PRODUCTION"
}

struct Server: Decodable {
    let partner: Partner
    let environment: Environment
}

struct Platform: Decodable {
    enum CodingKeys: String, CodingKey {
        case baseURL
    }
    
    let baseURL: URL?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseURL = URL(string: try container.decode(String.self, forKey: .baseURL))
    }
}

struct LoginResponseEntity: Decodable {
    let server: Server
    let platform: Platform
}
