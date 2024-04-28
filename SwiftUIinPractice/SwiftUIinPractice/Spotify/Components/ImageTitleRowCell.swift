//
//  ImageTitleRowCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 16/04/2024.
//

import SwiftUI

struct ImageTitleRowCell: View {
    var imageName: String = Constants.randomImage
    var imageSize: CGFloat = 100
    var title = "ana ahmed fathy"
    var body: some View {
        VStack(alignment: .leading ,spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize )
            Text(title)
                .font(.callout)
                .foregroundStyle(.spotlifyLightGray)
                .lineLimit(2)
                .padding(4)
            
            
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack {
        
        Color.black.ignoresSafeArea()
        ImageTitleRowCell()
    }
}
