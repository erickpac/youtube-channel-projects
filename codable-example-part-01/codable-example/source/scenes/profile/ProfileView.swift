//
//  ProfileView.swift
//  codable-example
//
//  Created by epac on 13/10/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    let username: String

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let user = viewModel.user {
                AvatarView(avatarURL: user.avatarUrl)
                UserDetailsView(user: user)
                AdditionalInfoView(user: user)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .task {
            await viewModel.fetchProfile(username: username)
        }
    }
}

struct AvatarView: View {
    let avatarURL: String?

    var body: some View {
        if let avatarURL = avatarURL, let url = URL(string: avatarURL) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 10)
            } placeholder: {
                ProgressView()
            }
        }
    }
}

struct UserDetailsView: View {
    let user: User

    var body: some View {
        VStack {
            Text(user.name)
                .font(.headline)
            Text("@\(user.login)")
                .font(.subheadline)
                .foregroundColor(.gray)
            if let bio = user.bio {
                Text(bio)
                    .padding()
            }
        }
    }
}

struct AdditionalInfoView: View {
    let user: User

    var body: some View {
        VStack {
            if let company = user.company {
                Text("Works at \(company)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Text("Public Repos: \(user.publicRepos)")
                .font(.footnote)
                .padding(.top)
        }
    }
}

#Preview {
    ProfileView(username: "erickpac")
}
