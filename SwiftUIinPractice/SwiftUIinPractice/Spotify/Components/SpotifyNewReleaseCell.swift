//
//  SpotifyNewReleaseCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 15/04/2024.
//

import SwiftUI

struct SpotifyNewReleaseCell: View {
    var imageName: String = Constants.randomImage
    var headline: String? = "New Release from"
    var supheadline: String? = "Some Artist"
    var title: String?  = "some playList"
    var subtitle: String?  = "Single - title"
    var onAddToPlayListPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack (spacing: 16){
            HStack {
                ImageLoaderView(urlString: imageName)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading,spacing: 2) {
                    if let headline {
                        Text(headline)
                            .font(.callout)
                            .foregroundStyle(.spotlifyLightGray)
                    }
                    if let supheadline {
                        Text(supheadline)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.spotlifyWhite)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                
                ImageLoaderView(urlString: imageName)
                    .frame(width: 140, height: 140)
                
                VStack (alignment: .leading, spacing: 32) {
                    
                    VStack(alignment: .leading, spacing: 2) {
                        
                        if let title {
                            Text(title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.spotlifyWhite)
                        }
                        
                        if let subtitle {
                            Text(subtitle)
                                .foregroundStyle(.spotlifyLightGray)
                        }
                    }
                    .font(.callout)
                    
                    
                    HStack {
                        
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.spotlifyLightGray)
                            .font(.title3)
                            .padding(4)
                            .onTapGesture {
                                onAddToPlayListPressed?()
                            }
                            .offset(x: -4)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(systemName: "play.circle.fill")
                            .foregroundStyle(.spotlifyWhite)
                            .font(.title)
                    }
                }
                .padding(.trailing, 16)
            }
            .themeColors(isSelected: false)
            .cornerRadius(8)
            .onTapGesture {
                onPlayPressed?()
            }
            
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        SpotifyNewReleaseCell()
            .padding(.horizontal)
    }
}
