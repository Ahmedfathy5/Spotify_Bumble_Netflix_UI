//
//  SongRowCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 17/04/2024.
//

import SwiftUI

struct SongRowCell: View {
    var imageSize: CGFloat = 50
    var imageName: String = Constants.randomImage
    var title: String = "ahmed fathy abdelmaksod abas"
    var subtitle: String? = "ana we enta we rakasny ya gad3"
    var onCellPressed: (()-> Void)? = nil
    var onElipsisPressed: (()-> Void)? = nil
    
    var body: some View {
        
        HStack(spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize , height: imageSize)
                .cornerRadius(5)
            
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.spotlifyWhite)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.callout)
                        .foregroundStyle(.spotlifyLightGray)
                }
            }
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.spotlifyWhite)
                .onTapGesture {
                    onElipsisPressed?()
                }
        }
        .onTapGesture {
            onCellPressed?()
        }
        
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        SongRowCell()
        SongRowCell()
        SongRowCell()
        SongRowCell()
        SongRowCell()
        
    }
}
