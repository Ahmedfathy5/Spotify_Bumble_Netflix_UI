//
//  NetflixMovieDetailView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 27/04/2024.
//

import SwiftUI
import SwiftfulRouting

struct NetflixMovieDetailView: View {
    var product: Product = .mock
    @State private var progress: Double = 0.2
    @State private var isMyList:Bool = false
    @State private var products: [Product] = []
    
    @Environment(\.router) var router

    
    var body: some View {
        
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            VStack(spacing: 0) {
                NetflixHeaderDetailView(
                    imageName: product.firstImage,
                    progress: progress,
                    onAirPlayPressed: nil,
                    onXMarkPressed: {
                        router.dismissScreen()
                    }
                )
                ScrollView(.vertical) {
                    VStack( alignment: .leading,spacing: 16) {
                        detailsProductSection
                        buttonSections
                        productGridSection
                    }
                    .padding(8)
                    
                }
                .scrollIndicators(.hidden)
            }
            .task {
                await getData()
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    private func getData() async {
        guard products.isEmpty else { return }
        do {
            products = try await DatabaseHelper().getProducts()
        } catch  {
            
        }
    }
    private var detailsProductSection: some View {
        NetflixDetailProductView(
            title: product.title,
            isNew: true,
            yearReleased: "2024",
            seasonCount: 4,
            hasClosedCaption: true,
            isTopTen: 6,
            descriptionText: product.description) {
                
            } onDownloadPressed: {
                
            }
    }
    private var buttonSections: some View {
        HStack(spacing: 32) {
            
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }
            RateButton { selection in
                
            }
            ShareButton()
            
        }
        .padding(.horizontal, 32)
    }
    private var productGridSection: some View {
        VStack(alignment: .leading) {
            Text("More Like this")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 8), count: 3), alignment: .center, spacing: 8, pinnedViews: []) {
                ForEach(products) { product in
                    NetflixMovieCell(
                        imageName: product.firstImage,
                        title: product.title,
                        isRecentlyAdded: product.recentlyAdded,
                        topTenRanking: nil
                    )
                    .onTapGesture {
                        onProductPressed(product: product)
                    }
                }
            }
            
        }
        .foregroundColor(.netflixWhite)
    }
    private func onProductPressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixMovieDetailView(product: product)
        }
    }
    
}

#Preview {
    RouterView { _ in
        NetflixMovieDetailView()
    }
}
