//
//  SpotifyHomeView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 15/04/2024.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var product: [Product] = []
    @State private var productRows: [ProductRow] = []
    
    @Environment(\.router) var router

    var body: some View {
        ZStack {
            Color.spotlifyBlack.ignoresSafeArea()
            ScrollView(.vertical) {
                LazyVStack ( spacing: 1, pinnedViews: [.sectionHeaders] ) {
                    Section {
                        VStack(spacing: 16) {
                            recentSections
                            if let product = product.first {
                                newReleaseSection(product: product)
                            }
                            listRows
                            
                        }
                    } header: {
                        header
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    private func getData() async {
        guard product.isEmpty else { return }
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            product = try await Array(DatabaseHelper().getProducts().prefix(8))
            
            var rows: [ProductRow] = []
            let allBrands =  Set( product.map { $0.brand } )
            for brand in allBrands {
                rows.append(ProductRow(title: brand.capitalized, products: product ))
            }
            productRows = rows
            
        } catch  {
            
        }
    }
    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotlifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            router.dismissScreen()
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                    
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading , 8)
        .frame(maxWidth: .infinity)
        .background(Color.spotlifyBlack)
    }
    private var recentSections: some View {
        
        
        VStack {
            NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: product) { product in
                if let product {
                    SpotifyRecentCell(imageName: product.firstImage, title: product.title)
                        .asButton(.press) {
                            goToPlaylistView(product: product)
                            
                        }
                }
            }
        }
    }
    private func newReleaseSection(product: Product) -> some View {
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand,
            supheadline: product.category,
            title: product.title,
            subtitle: product.description,
            onAddToPlayListPressed: nil,
            onPlayPressed: nil
        )
        .asButton(.press) {
            goToPlaylistView(product: product)
        }
        .padding(.horizontal)
    }
    private var listRows: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotlifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                ScrollView(.horizontal) {
                    
                    HStack ( alignment: .top ,spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(
                                imageName: product.firstImage,
                                imageSize: 120,
                                title: product.title
                            )
                            .asButton(.press) {
                                goToPlaylistView(product: product )
                            }
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    private func goToPlaylistView(product: Product) {
        guard let currentUser else { return }
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: currentUser)
        }
        
    }
}

#Preview {
    RouterView { _ in
        SpotifyHomeView()

    }
    
}
