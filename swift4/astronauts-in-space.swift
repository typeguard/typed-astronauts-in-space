// To parse the JSON, add this file to your project and do:
//
//   guard let astronautsInSpace = try AstronautsInSpace(json) else { ... }
//   guard let iSSCurrentLocation = try ISSCurrentLocation(json) else { ... }

import Foundation

struct AstronautsInSpace: Codable {
    let number: Int
    let people: [Person]
    let message: String
}

struct Person: Codable {
    let craft, name: String
}

struct ISSCurrentLocation: Codable {
    let issPosition: IssPosition
    let timestamp: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case issPosition = "iss_position"
        case timestamp, message
    }
}

struct IssPosition: Codable {
    let longitude, latitude: String
}

// MARK: Convenience initializers

extension AstronautsInSpace {
    init(data: Data) throws {
        self = try JSONDecoder().decode(AstronautsInSpace.self, from: data)
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }

    init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}

extension Person {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Person.self, from: data)
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }

    init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}

extension ISSCurrentLocation {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ISSCurrentLocation.self, from: data)
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }

    init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}

extension IssPosition {
    init(data: Data) throws {
        self = try JSONDecoder().decode(IssPosition.self, from: data)
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else { return nil }
        try self.init(data: data)
    }

    init?(fromURL url: String) throws {
        guard let url = URL(string: url) else { return nil }
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString() throws -> String? {
        return String(data: try self.jsonData(), encoding: .utf8)
    }
}
