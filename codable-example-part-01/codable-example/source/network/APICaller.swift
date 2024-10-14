//
//  APICaller.swift
//  codable-example
//
//  Created by epac on 13/10/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct APICaller {

    let baseURL = "https://api.github.com/"

    /// Fetches data from the given endpoint and decodes it into the specified type.
    /// - Parameters:
    ///   - endpoint: The API endpoint to fetch data from.
    ///   - type: The type to decode the data into.
    /// - Returns: An instance of the specified type.
    /// - Throws: An error if the URL is invalid, the response is invalid, or the data cannot be decoded.
    func fetchData<T: Decodable>(from endpoint: String, as type: T.Type) async throws -> T {
        let urlString = baseURL + endpoint

        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            return try decoder.decode(T.self, from: data)
        } catch {
            print("Error decoding data: \(error)")
            throw APIError.invalidData
        }
    }
}


