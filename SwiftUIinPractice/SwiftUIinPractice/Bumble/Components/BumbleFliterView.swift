//
//  BumbleFliterView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 18/04/2024.
//

import SwiftUI

struct BumbleFliterView: View {
    var options:[String] = ["Everyone", "Trending"]
    @Binding var selection: String
    @Namespace private var nameSpace
    
    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: 32) {
                
                ForEach(options, id: \.self) { option in
                    VStack(spacing: 8) {
                        Text(option)
                            .frame(maxWidth: .infinity)
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        if selection == option {
                            RoundedRectangle(cornerRadius: 2)
                                .frame(height: 1.5)
                            // i use geometry effect here to animation.
                                .matchedGeometryEffect(id: "selection", in: nameSpace)
                        }
                        
                    }
                    .padding(.top, 8)
                    .foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
                    .onTapGesture {
                        selection = option
                    }
                }
            }
            .animation(.smooth, value: selection)
        }
    }
}

fileprivate struct BumbleFliterViewPreview: View {
    var options:[String] = ["Everyone", "Trending"]
    @State private var selection: String = "Everyone"
    var body: some View {
        BumbleFliterView(options: options, selection: $selection)
    }
}


#Preview {
    BumbleFliterViewPreview()
        .padding()
}
