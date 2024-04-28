//
//  interstPillGridView.swift
//  SwiftUIinPractice
//
//  Created by Ahmed Fathi on 18/04/2024.
//

import SwiftUI
import SwiftfulUI


// the model.
struct UserInterst: Identifiable {
    let id: String = UUID().uuidString
    var iconName:String? = nil
    var emoji:String? = nil
    var text: String
}


struct interstPillGridView: View {
    var intersts: [UserInterst] = User.mock.basic
    var body: some View {
        ZStack {
            
            
            NonLazyVGrid(
                columns: 2,
                alignment: .leading,
                spacing: 8,
                items: intersts) { interst in
                    if let interst {
                        interstPillView(
                            iconName: interst.iconName,
                            emoji: interst.emoji,
                            text: interst.text
                        )
                    } else {
                        EmptyView()
                    }

                }
            
            
            
            
            
            
            
        }
    }
}

#Preview {
    
    VStack (spacing: 40){
        interstPillGridView(intersts: User.mock.basic)
        interstPillGridView(intersts: User.mock.intersts)

        
        
    }
    
}

