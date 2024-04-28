//
//  NetflixFilterCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 23/04/2024.
//

import SwiftUI

struct NetflixFilterCell: View {
    
    var title: String = "Categories"
    var isDropDown: Bool = true
    var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
            if isDropDown {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack {
               
                    Capsule(style: .circular)
                        .fill(.netflixDarkGray)
                        .opacity(isSelected ? 1 : 0)
                    
                
                Capsule(style: .circular)
                    .stroke(lineWidth: 1)
                
                
            }
            
            
        )
        
        
        .foregroundColor(.netflixLightGray)
    }
}

#Preview {
    ZStack {
        
        Color.netflixBlack.ignoresSafeArea()
        
        VStack {
            NetflixFilterCell()
            NetflixFilterCell(isDropDown: false)
            NetflixFilterCell(isSelected: true)

        }
        
        
    }
    
    
    
    
    
}
