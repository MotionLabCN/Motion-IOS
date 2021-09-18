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
            LazyVStack {
                ForEach(1...119, id: \.self) { count in
                    PostCell()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    Divider.mt.defult()
                }
            }
            .frame(maxWidth: .infinity)
        }
     
    }
}

struct RecommendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendView()
    }
}
