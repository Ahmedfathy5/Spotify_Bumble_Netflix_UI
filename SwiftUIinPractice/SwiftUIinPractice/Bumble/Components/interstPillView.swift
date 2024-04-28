//
//  interstPillView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 18/04/2024.
//

import SwiftUI

struct interstPillView: View {
    var iconName:String? = "heart.fill"
    var emoji: String? = "👌🏻"
    var text: String = "i got a fiver so can you check "
    
    var body: some View {
        ZStack {
            HStack(spacing: 4) {
                if let iconName {
                    Image(systemName: iconName)
                } else if let emoji {
                    Text(emoji)
                    
                }
                Text(text)
                
                
            }
            .font(.callout)
            .fontWeight(.medium)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .foregroundStyle(.bumbleBlack)
            .background(.bumbleLightYellow)
            .cornerRadius(32)
            
            
            
            
        }
        
    }
}

#Preview {
    VStack {
        
        interstPillView(iconName: nil)
        interstPillView()
        interstPillView()
        
    }
}
