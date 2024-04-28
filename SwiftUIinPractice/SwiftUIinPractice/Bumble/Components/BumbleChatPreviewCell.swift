//
//  BumbleChatPreviewCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 21/04/2024.
//

import SwiftUI

struct BumbleChatPreviewCell: View {
    
    var imageName: String = Constants.randomImage
    var precentageRemaining: Double = Double.random(in: 0...1)
    var hasNewMessage: Bool = true
    var userName: String = "Ahmed elsaka"
    var lastChatMessage: String? = "Hello babe, I hope you got in Hell very soon❤️"
    var isYourMove:Bool = true
    
    var body: some View {
        HStack(spacing: 16) {
            BumbleProfileImageCell(
                imageName: imageName,
                precentageRemaining: precentageRemaining,
                hasNewMessage: hasNewMessage
            )
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 0) {
                    Text(userName)
                        .font(.headline)
                        .foregroundStyle(.bumbleBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    if isYourMove {
                        
                        Text("your Move")
                            .font(.caption2)
                            .bold()
                            .padding(.vertical, 6)
                            .padding(.horizontal, 4)
                            .background(.bumbleYellow)
                            .cornerRadius(32)
                    }
                }
                if let lastChatMessage {
                    Text(lastChatMessage)
                        .font(.subheadline)
                        .foregroundStyle(.bumbleGray)
                        .lineLimit(1)
                        .padding(.trailing, 16)
                    
                    
                }
                
            }
             
            
            
        }
    }
}

#Preview {
    BumbleChatPreviewCell()
        .padding()
}
