//
//  ShareButton.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 27/04/2024.
//

import SwiftUI

struct ShareButton: View {
    var urlstring: String = "Ahmed fathy basha was here"
    
    var body: some View {
        ZStack {
            ShareLink(item: urlstring) {
                VStack(spacing: 8) {
                    
                    Image(systemName: "paperplane")
                        .font(.title)
                    
                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGray)
                }
                .foregroundColor(.white)
                .padding(8)
               
            }
            
            
        }
        
        
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ShareButton()
    }
}
