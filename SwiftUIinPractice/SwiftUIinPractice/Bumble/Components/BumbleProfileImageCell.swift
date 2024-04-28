//
//  BumbleProfileImageCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 21/04/2024.
//

import SwiftUI

struct BumbleProfileImageCell: View {
    var imageName: String = Constants.randomImage
    var precentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.bumbleGray, lineWidth: 2)
            
            Circle()
                .trim(from: 0, to: precentageRemaining)
                .stroke(.bumbleYellow, lineWidth: 4)
                .rotationEffect(Angle(degrees: -90))
            // I use it to reverse the circle line.
                .scaleEffect(x: -1, y: 1, anchor: .center)
            
            ImageLoaderView(urlString: imageName)
                .clipShape(Circle())
                .padding(4)
        }
        .frame(width: 75, height: 75)
        .overlay(
            ZStack {
                
                if hasNewMessage {
                    Circle()
                        .fill(.bumbleWhite)
                    
                    Circle()
                        .fill(.bumbleYellow)
                        .padding(2)
                }
            }
                .frame(width: 20, height: 20)
                .offset(x: 2, y: 2)
            , alignment: .bottomTrailing
        )
    }
}

#Preview {
    
    VStack {
        BumbleProfileImageCell()
        BumbleProfileImageCell()
        BumbleProfileImageCell()
        BumbleProfileImageCell()
        BumbleProfileImageCell()
    }
    
}
