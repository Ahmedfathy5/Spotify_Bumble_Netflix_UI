//
//  NetflixFilterBarView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 23/04/2024.
//

import SwiftUI

struct FilterModel: Equatable, Hashable , Identifiable {
    var id = UUID().uuidString
    let title: String
    let isDropDown: Bool
    
    static var mockArray: [FilterModel] = [
        FilterModel(title: "TV Shows", isDropDown: false),
        FilterModel(title: "Movies", isDropDown: false),
        FilterModel(title: "Categories", isDropDown: true)
    ]
    
    
    
}



struct NetflixFilterBarView: View {
    var filters: [FilterModel] = FilterModel.mockArray
    var onXmarkPressed: (() -> Void)? = nil
    var onFilterPressed: ((FilterModel) -> Void)? = nil
    var selectedFilter: FilterModel? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundColor(.netflixLightGray)
                        .onTapGesture {
                            onXmarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                }
                
                
                ForEach(filters) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixFilterCell(
                            title: filter.title ,
                            isDropDown: filter.isDropDown,
                            isSelected: selectedFilter == filter
                        )
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 16 : 0)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}

// i make this to take action and update UI. it's instade Binding.

fileprivate struct NetflixFilterBarViewPreview: View {
    @State private var filters: [FilterModel] = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    var body: some View {
        
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
        
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixFilterBarViewPreview()
    }
}
