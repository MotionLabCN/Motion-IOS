//
//  NotificationView.swift
//  NotificationView
//
//  Created by Liseami on 2021/9/15.
//

import SwiftUI
import MotionComponents

struct NotificationView: View {
    @Namespace var namespace
    @State var showIndex = 0
    var body: some View {
        HStack {
            ZStack {
                Text("码力")
                if showIndex == 0 {
                    Rectangle()
                        .matchedGeometryEffect(id: "indictor", in: namespace)
                        .frame(width: 50, height: 1)
                        .offset( y: 20)
                }
            }
            .onTapGesture(perform: {
                withAnimation {
                    showIndex = 0

                }
            })
            ZStack {
                Text("算力")
                if showIndex == 1 {
                    Rectangle()
                        .matchedGeometryEffect(id: "indictor", in: namespace)
                        .frame(width: 50, height: 1)
                        .offset( y: 20)
                }
            }
            .onTapGesture(perform: {
                withAnimation {
                    showIndex = 1

                }
            })
            ZStack {
                Text("人力")
                if showIndex == 2 {
                    Rectangle()
                        .matchedGeometryEffect(id: "indictor", in: namespace)
                        .frame(width: 50, height: 1)
                        .offset( y: 20)
                }
            }
            .onTapGesture(perform: {
                withAnimation {
                    showIndex = 2

                }
            })

        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
