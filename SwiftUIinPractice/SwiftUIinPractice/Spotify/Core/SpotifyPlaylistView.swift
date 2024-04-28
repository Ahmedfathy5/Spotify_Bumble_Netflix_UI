//
//  SpotifyPlayListView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 16/04/2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    var product: Product = .mock
    var user: User = .mock
    
    @State private var products: [Product] = []
    @State private var showHeader: Bool = false
    
    @Environment(\.router) var router
    
    var body: some View {
        
        ZStack {
            Color.spotlifyBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack(spacing: 12){
                    PlaylistHeaderCell(
                        title: product.title,
                        subtitle: product.brand,
                        imageName: product.firstImage,
                        height: 250
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 150
                    }
                    
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category,
                        onAddToPlaylistPress: nil,
                        onDownloadPress: nil,
                        onSharePress: nil,
                        onEllipsisPress: nil,
                        onShufflePress: nil,
                        onPlayPress: nil
                    )
                    .padding(.top, 15)
                    .padding(.horizontal, 16)
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 50,
                            imageName: product.firstImage,
                            title: product.title,
                            subtitle: product.brand,
                            onCellPressed: {
                                goToPlaylistView(product: product)
                                
                            },
                            onElipsisPressed: nil
                        )                    .padding(.horizontal, 16)
                        
                    }
                }
            }
            ZStack{
                
                Text(product.title)
                    .font(.headline)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.spotlifyBlack)
                    .offset(y: showHeader ? 0 : -40 )
                    .opacity(showHeader ? 1 : 0)
                
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .padding(10)
                    .background(showHeader ? Color.black.opacity(0.001) : .spotlifyGray.opacity(0.7))
                    .clipShape(Circle())
                    .onTapGesture {
                        router.dismissScreen()
                    }
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(.spotlifyWhite)
            .animation(.smooth(duration: 0.2), value: showHeader)
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    private func getData() async {
        // i put it cause if the products has already a data it shouldn't  reload again.
        guard products.isEmpty else { return }

        do {
            products = try await DatabaseHelper().getProducts()
        } catch  {
            
        }
    }
    private func goToPlaylistView(product: Product) {
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: user)
        }
        
    }

}

#Preview {
    
    RouterView { _ in
        SpotifyPlaylistView()
    }
    
}
