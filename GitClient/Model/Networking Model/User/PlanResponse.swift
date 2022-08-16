// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let plan = try Plan(json)

import Foundation

// MARK: - Plan
struct PlanResponse: Codable {
    let name: String?
    let space, collaborators, privateRepos: Int?

    enum CodingKeys: String, CodingKey {
        case name, space, collaborators
        case privateRepos = "private_repos"
    }
}

// MARK: Plan convenience initializers and mutators

extension PlanResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(PlanResponse.self, from: data)
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
        name: String?? = nil,
        space: Int?? = nil,
        collaborators: Int?? = nil,
        privateRepos: Int?? = nil
    ) -> PlanResponse {
        return PlanResponse(
            name: name ?? self.name,
            space: space ?? self.space,
            collaborators: collaborators ?? self.collaborators,
            privateRepos: privateRepos ?? self.privateRepos
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
