//
//  RateButton.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 27/04/2024.
//

import SwiftUI

enum rateOptions: String, CaseIterable{
    case dislike, like , love
    
    var title: String {
        switch self {
        case .dislike:
            "Not for me"
        case .like:
            "I like this"
        case .love:
            "Love this!"
        }
    }
    var iconName: String {
        switch self {
        case .dislike:
            "hand.thumbsdown"
        case .like:
            "hand.thumbsup"
        case .love:
            "bolt.heart"
        }
    }
}

struct RateButton: View {
    @State private var showPopover: Bool = false
    var onRatingSelection: ((rateOptions) -> Void)? = nil
    var body: some View {
        VStack(spacing: 8) {
            
            Image(systemName: "hand.thumbsup")
                .font(.title)
            
            Text("Rate")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundColor(.white)
        .padding(8)
        .onTapGesture {
            showPopover.toggle()
        }
        .popover(isPresented: $showPopover ) {
            ZStack {
                Color.netflixDarkGray.ignoresSafeArea()
                HStack(spacing: 15) {
                    ForEach(rateOptions.allCases, id: \.self) { option in
                        rateButton(option: option)
                    }

                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                
            }
            .presentationCompactAdaptation(.popover)
        }
        
    }
    private func rateButton(option: rateOptions) -> some View {
        VStack(spacing: 8) {
            Image(systemName: option.iconName)
                .font(.title2)
            Text(option.title)
                .font(.caption)
        }
        .foregroundColor(.netflixWhite)
        .padding(4)
        .onTapGesture {
            showPopover = false
            onRatingSelection?(option)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        RateButton()
    }
}
