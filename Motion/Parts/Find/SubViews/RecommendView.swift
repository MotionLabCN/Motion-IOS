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
    
    @StateObject private var vm = RecommendVM()
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack {
                
                if showMoney {
                    MoneyNotiView()
                }
                
                ForEach(vm.list) { item in
                    Button {
                        showDetail.toggle()
                    } label: {
                        
                        PostCell(model: item)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                    }
                    .mtTapAnimation(style: .rotation3D)
                    

                   
                    Divider.mt.defult()
                }
            }
            .frame(maxWidth: .infinity)
            
            Spacer.mt.tabbar()

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
