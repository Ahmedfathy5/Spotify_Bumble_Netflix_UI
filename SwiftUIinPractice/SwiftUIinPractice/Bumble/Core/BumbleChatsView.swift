//
//  BumbleChatsView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 21/04/2024.
//

import SwiftUI
import SwiftfulRouting

struct BumbleChatsView: View {
    @State private var allUsers: [User] = []
    @Environment(\.router) var router
    
    
    var body: some View {
        
        ZStack {
            
            Color.bumbleWhite.ignoresSafeArea()
            VStack {
                header
                    .padding(16)
                matchQueuSection
                recentChatsSections
                
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    private func getData() async {
        
        guard allUsers.isEmpty else { return }
        
        do {
            allUsers = try await DatabaseHelper().getUsers()
        } catch {
            
        }
    }
    private var header: some View {
        HStack(spacing: 0) {
            Image(systemName: "line.horizontal.3")
                .onTapGesture {
                    router.dismissScreen()
                }
            Spacer(minLength: 0)
            Image(systemName: "magnifyingglass")
        }
        .font(.title)
        .fontWeight(.medium)
    }
    private var matchQueuSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Group {
                Text("Match Queue")
                
                +
                Text("(\(allUsers.count))")
                    .foregroundStyle(.bumbleGray)
            }
            .padding(.horizontal , 16)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(allUsers) { user in
                        BumbleProfileImageCell(
                            imageName: user.image,
                            precentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random()
                        )
                    }
                }
                .padding(.horizontal , 16)
            }
            .frame(height: 100)
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }
    private var recentChatsSections: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack(spacing: 0) {
                Group {
                    Text("Chats")
                    
                    +
                    Text("(Recent)")
                        .foregroundStyle(.bumbleGray)
                }
                Spacer(minLength: 0)
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title2)
            }
            .padding(.horizontal , 16)
            
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 16) {
                    ForEach(allUsers) { user in
                        BumbleChatPreviewCell(
                            imageName:  user.images.randomElement()!,
                            precentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random(),
                            userName: user.firstName,
                            lastChatMessage: user.aboutMe,
                            isYourMove: Bool.random()
                        )
                    }
                }
                .padding(16)
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        
    }
}

#Preview {
    BumbleChatsView()
}
