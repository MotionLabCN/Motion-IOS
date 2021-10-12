//
//  RecommendView.swift
//  RecommendView
//
//  Created by Liseami on 2021/9/16.
//

import SwiftUI
import MotionComponents

struct RecommendView: View {
    @State private var showMoney : Bool = false
    @State private var showDetail : Bool = false
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack {
                
                if showMoney {
                    MoneyNotiView()
                }
                
                ForEach(1...119, id: \.self) { count in
                    Button {
                        showDetail.toggle()
                    } label: {
                        
                        PostCell()
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                    }
                    .mtTapAnimation(style: .normal)
                    

                   
                    Divider.mt.defult()
                }
            }
            .frame(maxWidth: .infinity)
        }
        
        //Money💰💰💰💰💰💰
        .onAppear {
            print("Recommend onAppear")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation {
                    self.showMoney = true
                }
            }
        }
        .onDisappear {
            print("Recommend onDisappear")

            self.showMoney = false
        }
        .mtFullScreenCover(isPresented: $showDetail) {
            BlurView(style: .systemChromeMaterialDark).ignoresSafeArea()
            PostDetailView()
        }

    }
}

struct RecommendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendView()
    }
}
