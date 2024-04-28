//
//  BumbleHomeView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 18/04/2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View {
    var filters:[String] = ["Everyone", "Trending"]
    // i use app storage instade @State to save my last choice.
    @AppStorage("bumble_home_filter") private var selectedFilter: String = "Everyone"
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0
    @State private var currentSwipeOffset: CGFloat = 0
    @Environment(\.router) var router
    
    
    // it's a dictionary
    @State private var cardOffsets: [Int:Bool] = [:] // UserId : (Direction is Right == True)
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            VStack(spacing: 12){
                header
                BumbleFliterView(options: filters, selection: $selectedFilter)
                    .background(Divider(),alignment: .bottom)
                
                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array( allUsers.enumerated()), id: \.offset) {(index , user) in
                            // what im gonna do is to load the three screen in the memory.
                            let isPrevious = (selectedIndex - 1 ) == index
                            let isCurrent = selectedIndex == index
                            let isNext = (selectedIndex + 1) == index
                            
                            if isPrevious || isCurrent || isNext {
                                let OffsetValue = cardOffsets[user.id]
                                userProfileCell(user: user, index: index)
                                
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(x: OffsetValue == nil ? 0 : OffsetValue == true  ? 900 : -900)
                            }
                            
                        }
                        
                        
                    } else {
                        ProgressView()
                    }
                    
                    overlaySwipingIndicator
                        .zIndex(999)
                    
                }
                  //  .animation(.smooth, value: currentSwipeOffset)
                .frame(maxHeight: .infinity)
                .padding(4)
             // i try it's sucks  .animation(.smooth, value: cardOffsets)
            }
            .padding(8)
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
    private func userDidSelected(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffsets[user.id] = isLike
        
        
        selectedIndex += 1
    }
    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .onTapGesture {
                        
                    }
                
                
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .onTapGesture {
                        router.dismissScreen()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Text("Bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .onTapGesture {
                    router.showScreen(.push) { _ in
                     BumbleChatsView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
        //    .frame(maxHeight: .infinity, alignment: .top)
        
    }
    private func userProfileCell(user: User,index: Int) -> some View {
        BumbleCardView(user: user)
        
            .withDragGesture(
                .horizontal,
                // it mean if i don't drag 10 left or right it will make the piority to scrollView.
                minimumDistance: 20,
                resets: true ,
                rotationMultiplier: 1.05,
                //                                        scaleMultiplier: 0.8,
                onChanged: { dragOffset in
                    currentSwipeOffset = dragOffset.width
                },
                onEnded: { dragOffset in
                    if dragOffset.width < -50 {
                        userDidSelected(index: index, isLike: true)
                    } else if dragOffset.width > 50 {
                        userDidSelected(index: index, isLike: false)
                    }
                    
                    
                }
            )
    }
    private var overlaySwipingIndicator: some View {
        ZStack {
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                )
                .frame(width: 60, height: 60)
            // i use it to make the shap bigger.
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1)
                .offset(x: min(-currentSwipeOffset, 250)  )
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                )
                .frame(width: 60, height: 60)
            // i use it to make the shap bigger.
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5 : 1)
                .offset(x: max(-currentSwipeOffset, -250)  )
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
            
        }
        .animation(.smooth, value: currentSwipeOffset)
        
    }
    
    
}

#Preview {
    RouterView { _ in 
    BumbleHomeView()
    }
}
