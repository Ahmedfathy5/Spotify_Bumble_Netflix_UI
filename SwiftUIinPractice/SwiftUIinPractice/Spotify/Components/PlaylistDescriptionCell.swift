//
//  PlaylistDescriptionCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 16/04/2024.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    var descriptionText: String = Product.mock.description
    var userName: String = "Ahmed fathy"
    var subheadline: String = "some headline goes here"
    var onAddToPlaylistPress: (() -> Void)? = nil
    var onDownloadPress: (() -> Void)? = nil
    var onSharePress: (() -> Void)? = nil
    var onEllipsisPress: (() -> Void)? = nil
    var onShufflePress: (() -> Void)? = nil
    var onPlayPress: (() -> Void)? = nil
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(descriptionText)
                .foregroundStyle(.spotlifyLightGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            madeSomeView
            Text(subheadline)
            buttonsRow
            
            
            
            
            
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotlifyLightGray)
        
    }
    private var madeSomeView: some View {
        HStack(spacing: 8) {
            
            Image(systemName:"applelogo")
                .font(.title3)
                .foregroundStyle(.spotlifyGreen)
            Text("Made for ")
            +
            Text(userName)
                .bold()
                .foregroundStyle(.spotlifyWhite)
            
            
            
        }
        
    }
    private var buttonsRow: some View {
        HStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "ellipsis")
                    .padding(8)
                    .onTapGesture {
                        
                    }
                
            }
            .offset(x: -8)
            
            .frame(maxWidth: .infinity , alignment: .leading)
            
            HStack(spacing: 8) {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 46))
                    .onTapGesture {
                        
                    }
                
            }
            .foregroundStyle(.spotlifyGreen)
            
            
        }
        .font(.title2)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PlaylistDescriptionCell()
            .padding()
    }
    
}
