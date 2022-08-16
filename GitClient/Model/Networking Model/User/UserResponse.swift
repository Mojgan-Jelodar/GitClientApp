// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userResponse = try UserResponse(json)

import Foundation

// MARK: - UserResponse
struct UserResponse: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?
    let name, company, blog: String?
    let location: String?
    let email: String?
    let hireable : Bool?
    let bio: String?
    let twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int?
    let createdAt, updatedAt: String?
    let privateGists, totalPrivateRepos, ownedPrivateRepos, diskUsage: Int?
    let collaborators: Int?
    let twoFactorAuthentication: Bool?
    let plan: PlanResponse?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case privateGists = "private_gists"
        case totalPrivateRepos = "total_private_repos"
        case ownedPrivateRepos = "owned_private_repos"
        case diskUsage = "disk_usage"
        case collaborators
        case twoFactorAuthentication = "two_factor_authentication"
        case plan
    }
}

// MARK: UserResponse convenience initializers and mutators

extension UserResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(UserResponse.self, from: data)
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
        login: String?? = nil,
        id: Int?? = nil,
        nodeID: String?? = nil,
        avatarURL: String?? = nil,
        gravatarID: String?? = nil,
        url: String?? = nil,
        htmlURL: String?? = nil,
        followersURL: String?? = nil,
        followingURL: String?? = nil,
        gistsURL: String?? = nil,
        starredURL: String?? = nil,
        subscriptionsURL: String?? = nil,
        organizationsURL: String?? = nil,
        reposURL: String?? = nil,
        eventsURL: String?? = nil,
        receivedEventsURL: String?? = nil,
        type: String?? = nil,
        siteAdmin: Bool?? = nil,
        name: String?? = nil,
        company: String?? = nil,
        blog: String?? = nil,
        location: String?? = nil,
        email: String?? = nil,
        hireable: Bool?? = nil,
        bio: String?? = nil,
        twitterUsername: String?? = nil,
        publicRepos: Int?? = nil,
        publicGists: Int?? = nil,
        followers: Int?? = nil,
        following: Int?? = nil,
        createdAt: String?? = nil,
        updatedAt: String?? = nil,
        privateGists: Int?? = nil,
        totalPrivateRepos: Int?? = nil,
        ownedPrivateRepos: Int?? = nil,
        diskUsage: Int?? = nil,
        collaborators: Int?? = nil,
        twoFactorAuthentication: Bool?? = nil,
        plan: PlanResponse?? = nil
    ) -> UserResponse {
        return UserResponse(
            login: login ?? self.login,
            id: id ?? self.id,
            nodeID: nodeID ?? self.nodeID,
            avatarURL: avatarURL ?? self.avatarURL,
            gravatarID: gravatarID ?? self.gravatarID,
            url: url ?? self.url,
            htmlURL: htmlURL ?? self.htmlURL,
            followersURL: followersURL ?? self.followersURL,
            followingURL: followingURL ?? self.followingURL,
            gistsURL: gistsURL ?? self.gistsURL,
            starredURL: starredURL ?? self.starredURL,
            subscriptionsURL: subscriptionsURL ?? self.subscriptionsURL,
            organizationsURL: organizationsURL ?? self.organizationsURL,
            reposURL: reposURL ?? self.reposURL,
            eventsURL: eventsURL ?? self.eventsURL,
            receivedEventsURL: receivedEventsURL ?? self.receivedEventsURL,
            type: type ?? self.type,
            siteAdmin: siteAdmin ?? self.siteAdmin,
            name: name ?? self.name,
            company: company ?? self.company,
            blog: blog ?? self.blog,
            location: location ?? self.location,
            email: email ?? self.email,
            hireable: hireable ?? self.hireable,
            bio: bio ?? self.bio,
            twitterUsername: twitterUsername ?? self.twitterUsername,
            publicRepos: publicRepos ?? self.publicRepos,
            publicGists: publicGists ?? self.publicGists,
            followers: followers ?? self.followers,
            following: following ?? self.following,
            createdAt: createdAt ?? self.createdAt,
            updatedAt: updatedAt ?? self.updatedAt,
            privateGists: privateGists ?? self.privateGists,
            totalPrivateRepos: totalPrivateRepos ?? self.totalPrivateRepos,
            ownedPrivateRepos: ownedPrivateRepos ?? self.ownedPrivateRepos,
            diskUsage: diskUsage ?? self.diskUsage,
            collaborators: collaborators ?? self.collaborators,
            twoFactorAuthentication: twoFactorAuthentication ?? self.twoFactorAuthentication,
            plan: plan ?? self.plan
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
