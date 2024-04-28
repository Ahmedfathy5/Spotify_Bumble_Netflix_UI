//
//  BumbleHeartView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 18/04/2024.
//

import SwiftUI


// i put this view in Bumble card view
struct BumbleHeartView: View {
    var body: some View {
        ZStack {
            
            
            Circle()
                .fill(.bumbleYellow)
                .frame(width: 40, height: 40)
            
            
            Image(systemName: "bubble.fill")
                .foregroundStyle(.bumbleBlack)
                .font(.system(size: 22))
                .offset(y: 2)
            
            Image(systemName: "heart.fill")
                .foregroundStyle(.bumbleYellow)
                .font(.system(size: 10))
            
            
            
        }
        .onTapGesture {
            
        }
    }
}

#Preview {
    BumbleHeartView()
}
