//
//  RecommendView.swift
//  RecommendView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

struct RecommendView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack{
                ForEach(0 ..< 40) { item in
                    PostCell()
                }
            }
            .padding()
        }
     
    }
}

struct RecommendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendView()
    }
}
