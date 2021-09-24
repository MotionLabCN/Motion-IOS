//
//  RecommendView.swift
//  RecommendView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

struct RecommendView: View {
    @State var showMoney : Bool = false
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack {
                
                if showMoney {
                    MoneyNotiView()
                }
                
                ForEach(1...119, id: \.self) { count in
                    PostCell()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    Divider.mt.defult()
                }
            }
            .frame(maxWidth: .infinity)
        }
        
        //Money💰💰💰💰💰💰
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation {
                    self.showMoney = true
                }
            }
        }
        .onDisappear {
            self.showMoney = false
        }
        
     
    }
}

struct RecommendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendView()
    }
}
