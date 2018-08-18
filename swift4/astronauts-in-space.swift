// To parse the JSON, add this file to your project and do:
//
//   let astronautsInSpace = try AstronautsInSpace(json)
//   let iSSCurrentLocation = try ISSCurrentLocation(json)

import Foundation

struct AstronautsInSpace: Codable {
    let message: String
    let people: [Person]
    let number: Int
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

// MARK: Convenience initializers and mutators

extension AstronautsInSpace {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(AstronautsInSpace.self, from: data)
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

    func with(
        message: String? = nil,
        people: [Person]? = nil,
        number: Int? = nil
    ) -> AstronautsInSpace {
        return AstronautsInSpace(
            message: message ?? self.message,
            people: people ?? self.people,
            number: number ?? self.number
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Person {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Person.self, from: data)
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

    func with(
        craft: String? = nil,
        name: String? = nil
    ) -> Person {
        return Person(
            craft: craft ?? self.craft,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension ISSCurrentLocation {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ISSCurrentLocation.self, from: data)
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

    func with(
        issPosition: IssPosition? = nil,
        timestamp: Int? = nil,
        message: String? = nil
    ) -> ISSCurrentLocation {
        return ISSCurrentLocation(
            issPosition: issPosition ?? self.issPosition,
            timestamp: timestamp ?? self.timestamp,
            message: message ?? self.message
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension IssPosition {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(IssPosition.self, from: data)
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

    func with(
        longitude: String? = nil,
        latitude: String? = nil
    ) -> IssPosition {
        return IssPosition(
            longitude: longitude ?? self.longitude,
            latitude: latitude ?? self.latitude
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
