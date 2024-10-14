//
//  ProfileViewModel.swift
//  codable-example
//
//  Created by epac on 13/10/24.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {

    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let api: APICaller = .init()

    func fetchProfile(username: String) async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            user = try await api.fetchData(from: "users/\(username)", as: User.self)
        } catch {
            errorMessage = "Failed to fetch user profile: \(error)"
        }
    }
}
