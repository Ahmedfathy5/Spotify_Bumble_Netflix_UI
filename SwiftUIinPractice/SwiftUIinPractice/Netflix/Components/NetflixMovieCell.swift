//
//  NetflixMovieCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 25/04/2024.
//

import SwiftUI

struct NetflixMovieCell: View {
    
    var imageName: String = Constants.randomImage
    var width: CGFloat = 90
    var height: CGFloat = 140
    var title: String? = "Movie Title"
    var isRecentlyAdded: Bool = false
    var topTenRanking: Int? = nil
    
    var body: some View {
        HStack(alignment: .bottom, spacing: -8) {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: 100, weight: .medium, design: .serif))
                    .offset(y: 20)
                
            }
            ZStack(alignment: .bottom) {
                
                ImageLoaderView(urlString: imageName)
                VStack (spacing: 0) {
                    // it take the first word of the sentence if it from 8 words it will take the first one.
                    if let title, let firstWord = title.components(separatedBy: " ").first {
                        Text(firstWord)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                        
                    }
                    // disscussion: what if i make if recently added instade the opacity
                    // the opacity will disappear and the movie will still inline
                    // if i make if condition it willn't be in the line and will offset down.
                    
                    Text("Recently Added")
                        .padding(.horizontal, 4)
                        .padding(.bottom, 2)
                        .frame(maxWidth: .infinity)
                        .background(.netflixRed)
                        .cornerRadius(2)
                        .offset(y: 2)
                        .lineLimit(1)
                        .font(.caption2.bold())
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal, 8)
                        .opacity(isRecentlyAdded ? 1 : 0)
                }
                .padding(.top, 6)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.3),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
            }
            .cornerRadius(4)
            .frame(width: width, height: height)
            .foregroundColor(.netflixWhite)

        }
        .foregroundStyle(.netflixWhite)


    }
}

#Preview {
    ZStack{
        Color.netflixBlack.ignoresSafeArea()
        
        
        VStack {
            NetflixMovieCell(topTenRanking: 1)
            NetflixMovieCell(isRecentlyAdded: true)
            NetflixMovieCell(isRecentlyAdded: false)
            NetflixMovieCell()
            NetflixMovieCell()
        }
        
        
    }
}
