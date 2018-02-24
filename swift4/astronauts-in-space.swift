// To parse the JSON, add this file to your project and do:
//
//   let astronautsInSpace = try AstronautsInSpace(json)
//   let iSSCurrentLocation = try ISSCurrentLocation(json)

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
    let message: String
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case issPosition = "iss_position"
        case message, timestamp
    }
}

struct IssPosition: Codable {
    let latitude, longitude: String
}

// MARK: Convenience initializers

extension AstronautsInSpace {
    init(data: Data) throws {
        self = try JSONDecoder().decode(AstronautsInSpace.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Person {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Person.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension ISSCurrentLocation {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ISSCurrentLocation.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension IssPosition {
    init(data: Data) throws {
        self = try JSONDecoder().decode(IssPosition.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
