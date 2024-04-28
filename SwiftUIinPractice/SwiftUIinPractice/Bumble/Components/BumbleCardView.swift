//
//  BumbleCardView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 18/04/2024.
//

import SwiftUI
import SwiftfulUI

struct BumbleCardView: View {
    var user: User = .mock
    @State private var cardFrame: CGRect = .zero
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0){
                
                headerCell
                    .frame(height: cardFrame.height)
                
                aboutMeSection
                    .padding([.horizontal,.vertical] , 24)
                
                myInterstsSection
                    .padding([.horizontal,.vertical] , 24)
                // if the image string have the same string so it will loop on only one image so i should change the string to loop on diffrent id.
                ForEach(user.images, id: \.self) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }
                
                locationSection
                    .padding([.horizontal,.vertical] , 24)
                
                footerSection
                    .padding([.top, .bottom ], 60)
                    .padding(.horizontal, 32)
            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay(
        superLikeButton
            .onTapGesture {
                
            }
            .padding(24)
         , alignment: .bottomTrailing
        )
        .cornerRadius(32)
        // i use it to make a height responsive with every device.
        .readingFrame { frame in
            cardFrame = frame
        }
    }
    
    
    
    
    private var headerCell: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoaderView(urlString: user.image)
            VStack(alignment: .leading,spacing: 8) {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4) {
                    Image(systemName: "suitcase")
                    Text(user.work)
                    
                }
                
                HStack (spacing: 4) {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                    
                }
                BumbleHeartView()
                    .onTapGesture {
                        
                    }
            }
            .padding(24)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [.bumbleBlack.opacity(0),
                             .bumbleBlack.opacity(0.6),
                             .bumbleBlack.opacity(0.6)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
        }
    }
    private func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
        
    }
    private var  aboutMeSection:some View {
        VStack(alignment: .leading, spacing: 12) {
            
            sectionTitle(title: "About Me")
            
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold )
                .foregroundStyle(.bumbleBlack)
            
            
            HStack(spacing: 0){
                
                BumbleHeartView()
                Text("Send a Compolimont")
                    .font(.caption)
                    .fontWeight(.semibold)
                
                
            }
            .padding([.horizontal, .trailing] , 8)
            .background(.bumbleYellow)
            .cornerRadius(32)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var myInterstsSection: some View {
        VStack(alignment:.leading , spacing: 12) {
            VStack(alignment:.leading , spacing: 8) {
                sectionTitle(title: "My basic")
                interstPillGridView(intersts: user.basic)
                
                
            }
            VStack(alignment:.leading , spacing: 8) {
                sectionTitle(title: "My interst")
                interstPillGridView(intersts: user.intersts)
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    private var locationSection: some View {
        VStack (alignment: .leading, spacing: 12) {
            
            HStack(spacing: 8) {
                
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Location")
                
                
            }
            .foregroundColor( .bumbleGray)
            .font(.body)
            .fontWeight(.medium)
            
            Text("10 miles away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            
            interstPillView(iconName: nil, emoji: "🇪🇬", text: "Lives in Egypy, Mansoura")
            
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var footerSection: some View {
        VStack (spacing: 24) {
            HStack( spacing: 0) {
                
                Circle()
                    .fill(.bumbleYellow)
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    )
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        
                    }
                
                Spacer(minLength: 0)
                Circle()
                    .fill(.bumbleYellow)
                    .overlay(
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    )
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        
                    }
            }
            Text("Hide and Report")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .onTapGesture {
                    
                }
            
        }
    }
    private var superLikeButton: some View {
        Image(systemName: "hexagon.fill")
           .foregroundColor(.bumbleYellow)
           .font(.system(size: 60))
           .overlay(
           Image(systemName: "star.fill" )
               .foregroundColor(.bumbleBlack)
               .font(.system(size: 30, weight: .medium))
           )
    }
    
    
    
    
}

#Preview {
    BumbleCardView()
        .padding(.vertical,40)
        .padding(.horizontal, 16)
}
