//
//  NotificationView.swift
//  NotificationView
//
//  Created by Liseami on 2021/9/15.
//

import SwiftUI
import MotionComponents

struct NotificationView: View {
    var body: some View {
    
        GeometryReader { geometry in
        
            ZStack {
                TabView {
                    Rectangle()
                        .fill(Color.random)
                    
                  
                    Rectangle()
                        .fill(Color.random)
                    Rectangle()
                        .fill(Color.random)
                    Rectangle()
                        .fill(Color.random)
                }
                .tabViewStyle(PageTabViewStyle())
                
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
