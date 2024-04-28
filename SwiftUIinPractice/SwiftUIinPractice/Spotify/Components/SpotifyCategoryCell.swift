//
//  SpotifyCategoryCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 15/04/2024.
//

import SwiftUI

struct SpotifyCategoryCell: View {
    var title: String = "Music"
    var isSelected:Bool = false
    var body: some View {
        Text(title)
            .font(.callout)
            .frame(minWidth: 35)
            .padding(.vertical, 8)
            .padding(.horizontal, 10)
            .foregroundStyle(.white)
            .themeColors(isSelected: isSelected)
            .cornerRadius(16 )
        
        
    }
}
extension View {
    
    func themeColors(isSelected: Bool) -> some View {
        self
            .background( isSelected ? .spotlifyGreen : .spotlifyDarkGray)
            .foregroundStyle( isSelected ? .spotlifyBlack : .spotlifyWhite)
    }
    
    
}


#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 40) {
            SpotifyCategoryCell()
            SpotifyCategoryCell()
            SpotifyCategoryCell()
            SpotifyCategoryCell()
            
            
            
        }
        
    }
}
