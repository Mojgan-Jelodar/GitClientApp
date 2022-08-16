// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let permissions = try Permissions(json)

import Foundation

// MARK: - Permissions
struct PermissionsResponse: Codable {
    let admin, maintain, push, triage: Bool?
    let pull: Bool?
}

// MARK: Permissions convenience initializers and mutators

extension PermissionsResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PermissionsResponse.self, from: data)
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
        admin: Bool?? = nil,
        maintain: Bool?? = nil,
        push: Bool?? = nil,
        triage: Bool?? = nil,
        pull: Bool?? = nil
    ) -> PermissionsResponse {
        return PermissionsResponse(
            admin: admin ?? self.admin,
            maintain: maintain ?? self.maintain,
            push: push ?? self.push,
            triage: triage ?? self.triage,
            pull: pull ?? self.pull
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
