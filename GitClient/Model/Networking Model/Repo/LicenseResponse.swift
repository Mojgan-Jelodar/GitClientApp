// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let license = try License(json)

import Foundation

// MARK: - License
struct LicenseResponse: Codable {
    let key, name, spdxID: String?
    let url: String?
    let nodeID: String?

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}

// MARK: License convenience initializers and mutators

extension LicenseResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(LicenseResponse.self, from: data)
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
        key: String?? = nil,
        name: String?? = nil,
        spdxID: String?? = nil,
        url: String?? = nil,
        nodeID: String?? = nil
    ) -> LicenseResponse {
        return LicenseResponse(
            key: key ?? self.key,
            name: name ?? self.name,
            spdxID: spdxID ?? self.spdxID,
            url: url ?? self.url,
            nodeID: nodeID ?? self.nodeID
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
