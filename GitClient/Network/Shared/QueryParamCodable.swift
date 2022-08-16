//
//  QueryParamEncoder.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation

struct QueryParamCodable<T: Codable > {
    func encode(_ item: T) throws -> String {
        let dictionary = item.dictionary
        let queryParams = encodeDictionary(dictionary ?? [:])
        return "?\(queryParams)"
    }
    func decode(_ item: String) throws -> T? {
        guard let url = URLComponents(string: item) else { return nil }
        var json : [String: Any] = [:]
        url.queryItems?.forEach({json[$0.name] = $0.value})
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

    private func encodeDictionary(_ dictionary: [String: Any]) -> String {
        return dictionary
            .compactMap { (key, value) -> String? in
                if value is [String: Any] {
                    if let dictionary = value as? [String: Any] {
                        return encodeDictionary(dictionary)
                    }
                } else {
                    return "\(key)=\(value)"
                }

                return nil
            }
            .joined(separator: "&")
    }
}
