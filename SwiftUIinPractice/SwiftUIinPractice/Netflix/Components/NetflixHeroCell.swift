//
//  NetflixHeroCell.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 25/04/2024.
//

import SwiftUI
import SwiftfulUI

struct NetflixHeroCell: View {
    var imageName: String = Constants.randomImage
    var isNetflixFilm: Bool = true
    var title: String = "Players"
    var catergories: [String] = ["Raunchy","Comedy","Romatic" ]
    var onBackgroundPressed: (()-> Void)? = nil
    var onPlayPressed: (()-> Void)? = nil
    var onMyListPressed: (()-> Void)? = nil

    
    
    var body: some View {
        ZStack(alignment: .bottom )   {
            ImageLoaderView(urlString: imageName)
            
            VStack (spacing: 16){
                VStack (spacing: 0){
                    if isNetflixFilm {
                        HStack (spacing: 8){
                            Text("N")
                                .foregroundStyle(.netflixRed)
                                .font(.largeTitle)
                                .fontWeight(.black)
                            Text("Film")
                            // kerning is to make space between characters.
                                .kerning(3)
                                .foregroundStyle(.netflixWhite)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            
                            
                        }
                    }
                   Text(title)
                        .font(.system(size: 50, weight: .medium, design: .serif))
                }
                HStack( spacing: 8){
                    ForEach(catergories, id: \.self) {category in
                        Text(category)
                            .font(.callout)
                        
                        if category != catergories.last {
                            Circle()
                                .frame(width: 4, height: 4)
                        }
                    }
                }
                HStack(spacing: 16) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Play")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundColor(.netflixDarkGray)
                    .background(.netflixWhite)
                    .cornerRadius(4)
                    .asButton(.press) {
                       onPlayPressed?()
                    }
                    HStack {
                        Image(systemName: "plus")
                        Text("My List")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundColor(.netflixWhite)
                    .background(.netflixDarkGray)
                    .cornerRadius(4)
                    .asButton(.press) {
                       onMyListPressed?()
                    }
                }
                .font(.callout)
                .fontWeight(.medium)
            }
            .padding(24)
            .background(
                LinearGradient(
                    colors: [
                        .netflixBlack.opacity(0),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4)

                    
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .foregroundColor(.netflixWhite)
            .aspectRatio(0.8, contentMode: .fit)
            .cornerRadius(10)
            .asButton(.tap) {
                onBackgroundPressed?()
            }
    }
}

#Preview {
    NetflixHeroCell()
        .padding(40)
}
