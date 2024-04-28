//
//  PlaylistHeaderCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 16/04/2024.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderCell: View {
    var title: String = "some title goes here"
    var subtitle: String = "subtitle goes here "
    var imageName: String = Constants.randomImage
    let shadowColor: Color = .spotlifyBlack.opacity(0.8)
    var height: CGFloat = 300
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay(
                ImageLoaderView(urlString: imageName)
            )
            .overlay (
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(subtitle)
                        .font(.headline)
                    Text(title)
                        .font(.largeTitle.bold())
                }
                    .foregroundStyle(.spotlifyWhite )
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(colors: [shadowColor.opacity(0), shadowColor], startPoint: .top, endPoint: .bottom)
                    )
                , alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: 300)
            .frame(height: height)
        
        
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
        
        
    }
    
    
}
