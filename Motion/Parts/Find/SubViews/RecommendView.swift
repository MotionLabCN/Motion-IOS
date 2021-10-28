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
    @State private var selectedPost : PostItemModel? = nil
    
    @State private var isShowToast = false
    @State private var toastText = ""
    
    @StateObject private var vm = RecommendVM()
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack {
                
//                if showMoney {
//                    MoneyNotiView()
//                }
                
                ForEach(vm.list) { item in
                    Button {
                        selectedPost = item
                    } label: {
                        
                        PostCell(model: item, didAlert: {
                            toastText = "举报成功，稍后人工客服会和您联系"
                            isShowToast = true
                        })
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
      
        .mtFullScreenCover(item: $selectedPost, content: { item in
            BlurView(style: .systemChromeMaterialDark).ignoresSafeArea()
            PostDetailView(inputPost: item)
        })
        
        .mtToast(isPresented: $isShowToast, text: toastText, postion: .bottom(offsetY: 86))

    }
}

struct RecommendView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendView()
    }
}
