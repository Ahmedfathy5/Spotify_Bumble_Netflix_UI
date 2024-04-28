//
//  NetflixHomeView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 23/04/2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting


struct NetflixHomeView: View {
    @State private var filters: [FilterModel] = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var scrollViewOffset: CGFloat = .zero
    
    
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    
    @Environment(\.router) var router
    
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
    
            backgroundGradiantLayer
            scrollViewLayers
            fullHeaderwithFilter
            
        }
        .foregroundColor(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
        
        
    }
    private func getData() async {
        guard productRows.isEmpty else { return }
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await DatabaseHelper().getProducts()
            heroProduct = products.first
            
            var rows: [ProductRow] = []
            let allBrands =  Set( products.map { $0.brand } )
            for brand in allBrands {
                rows.append(ProductRow(title: brand.capitalized, products: products.shuffled() ))
            }
            productRows = rows
            
        } catch  {
            
        }
    }
    private var backgroundGradiantLayer: some View {
        ZStack {
            LinearGradient(
                colors: [Color.netflixDarkGray.opacity(1),
                         Color.netflixDarkGray.opacity(0)
                        ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            LinearGradient(
                colors: [Color.netflixDarkRed.opacity(0.5),
                         Color.netflixDarkRed.opacity(0)
                        ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .frame(maxHeight: max(10 , (400 + (scrollViewOffset * 0.75))))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
        
        
    }
    private var fullHeaderwithFilter: some View {
        VStack (spacing:0) {
            header
                .padding(.horizontal, 16)
            if scrollViewOffset > -20 {
                NetflixFilterBarView(
                    filters: filters,
                    onXmarkPressed: {
                        selectedFilter = nil
                    },
                    onFilterPressed: { newFilter in
                        selectedFilter = newFilter
                    },
                    selectedFilter: selectedFilter
                )
                .padding(.top, 16)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 8)
        .background(
            ZStack {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(Color.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                    
                    
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderSize == .zero {
                fullHeaderSize = frame.size
                
            }
        }
    }
    
    private func onProductPressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixMovieDetailView(product: product)
        }
    }
    
    private var header: some View {
        HStack(spacing: 0){
            Text("for you")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }
            
            HStack(spacing:16) {
                
                
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
        }
    }
    private var scrollViewLayers: some View {
        ScrollViewWithOnScrollChanged( .vertical, showsIndicators: false) {
            VStack(spacing: 8) {
                // i create this to make space between the header and the poster.
                VStack {
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                }
                if let heroProduct {
                    heroCell(product: heroProduct)
                }
                categoryRows
                
            }
        } onScrollChanged: { offset in
            scrollViewOffset = offset.y
        }
    }
    private func heroCell(product: Product) -> some View {
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title,
            catergories:[ product.category.capitalized , product.brand],
            onBackgroundPressed:  {
                 onProductPressed(product: product)
            }, onPlayPressed: {
                onProductPressed(product: product)

            }, onMyListPressed: {
                
            }
        )
        .padding(24)
    }
    private var categoryRows: some View {
        LazyVStack(spacing:16 ) {
            // i make enumerated here to give the row a numbers.
            ForEach(Array(productRows.enumerated()), id: \.offset) { indexRow ,row in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row.title)
                        .font(.subheadline)
                        .padding(.horizontal, 16)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(row.products.enumerated()), id: \.offset) { index ,product in
                                NetflixMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    isRecentlyAdded: product.recentlyAdded,
                                    topTenRanking: (indexRow == 1) ? (index + 1) : nil
                                )
                                .onTapGesture {
                                     onProductPressed(product: product)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
}

#Preview {
    RouterView{ _ in
        NetflixHomeView()
        
    }
}
