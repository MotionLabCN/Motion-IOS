//
//  MessageView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/16.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 200, maximum: 300))], spacing: 20, pinnedViews: /*@START_MENU_TOKEN@*/[]/*@END_MENU_TOKEN@*/, content: {
                Section(header:
                        Text("header")
                            .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    Group {
                        Text("Placeholder")
                        Text("Placeholder")
                        /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
                        /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
                    }
                    
                }
                
                Section(header:
                        Text("header")
                            .frame(maxWidth: .infinity, alignment: .leading)
                ) {
                    Group {
                        Text("Placeholder")
                        Text("Placeholder")
                        /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
                        /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
                    }
                    
                }
                
            })
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
