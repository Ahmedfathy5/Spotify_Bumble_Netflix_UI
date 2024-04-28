//
//  NetflixDetailProductView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 27/04/2024.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailProductView: View {
    var title: String = "movie title "
    var isNew: Bool = true
    var yearReleased: String? = "2024"
    var seasonCount: Int? = 2
    var hasClosedCaption: Bool = true
    var isTopTen: Int? = 6
    var descriptionText: String? = "welcome here i'm ahmed fathy im the king you wait to kill you."
    var castText: String = "Cast: Ahmed Fathy, Nick , Menna shalapy."
    var onPlayPressed: (()->Void)? = nil
    var onDownloadPressed: ( ()->Void )? = nil
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 8) {
                if isNew {
                    Text("New")
                        .foregroundStyle(.green)
                }
                if let yearReleased {
                    Text(yearReleased)
                }
                
                
                if let seasonCount {
                    Text("\(seasonCount) Seasons")
                }
                
                if hasClosedCaption {
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundColor(.netflixLightGray)
            
            if let isTopTen {
                HStack(spacing:8) {
                    top10Icon
                    
                    Text("\(isTopTen) in TV Shows Today")
                        .font(.headline)
                }
            }
            VStack(spacing: 8) {
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
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Download")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundColor(.netflixWhite)
                .background(.netflixDarkGray)
                .cornerRadius(4)
                .asButton(.press) {
                    onDownloadPressed?()
                }
            }
            .font(.callout)
            .fontWeight(.medium)
            
            Group {
                if let descriptionText {
                    Text(descriptionText)
                }
                
              
                    Text(castText)
                        .foregroundStyle(.netflixLightGray)
                
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            
            
            
        }
        
        
        .foregroundColor(.netflixWhite)
        
    }
    
    private var top10Icon: some View {
        Rectangle()
            .fill(.netflixRed)
            .frame(width: 28, height: 28)
            .overlay(
                VStack(spacing:0) {
                    Text("TOP")
                        .fontWeight(.bold)
                        .font(.system(size: 8))
                        .offset(y:2)
                    Text("10")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                    
                    
                    
                }
                
            )
    }
}


#Preview {
    ZStack {
        
        Color.black.ignoresSafeArea()
        NetflixDetailProductView()
        
        
    }
    
    
}


