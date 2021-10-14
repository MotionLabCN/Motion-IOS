//
//  CodepowerView.swift
//  Motion
//
//  Created by Liseami on 2021/9/29.
//

import SwiftUI
import MotionComponents
import Kingfisher

struct CodepowerView: View {
    
    @EnvironmentObject var vm: FindVM
    //    @Binding var isShowmtsheet: Bool
    @State  var offsetAnimation  : Bool = false
    let animation = Animation.linear(duration: 10).repeatForever(autoreverses: true)
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            
            VStack(spacing:12){
                
                Spacer().frame(width: 0, height: 44)
                
                title
                
                Spacer().frame(width: 0, height: 36)
                
                scrollAnimation
                
                Spacer().frame(width: 0, height: 36)
                
                Button("上架技术方案"){}
                .mtButtonStyle(.mainGradient)
                .padding(.horizontal,80)
                
                Spacer().frame(width: 0, height: 12)
                
                shopTitle
                
                productList
                
            }
        }
        .frame(width: ScreenWidth())
        .onAppear {
            print("22222")
        }
    }
    
    var title : some View {
        VStack(spacing:6){
            Text("技术方案在这里流通与落地")
                .font(.mt.largeTitle.mtBlod() ,textColor: .black)
                .multilineTextAlignment(.center)
                .padding(.horizontal,70)
            
            Text("基于去中心化的分布式存储协议，享受存储服务的同时。")
                .font(.mt.body2,textColor: .mt.gray_500)
                .lineSpacing(6)
                .padding(.horizontal,56)
        }
    }
    
    @ViewBuilder
    var scrollAnimation : some View {
        ScrollViewReader { prox in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack{
                    Spacer().frame(width: 16,height: 160)
                    
                    ForEach(0 ... 5000, id: \.self) { item in
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.random)
                            .frame(width: 100, height: 140)
                            .offset(y: item % 2 == 0 ? 10 : -10 )
                    }
                }
                //                .offset(x: offsetAnimation ? -300 : 0)
                .onAppear {
                    DispatchQueue.main.async {
                        prox.scrollTo(2500, anchor: .center)
                    }
                    //                    withAnimation(self.animation){
                    //                        self.offsetAnimation.toggle()
                    //                    }
                }
            }
        }
    }
    
    var shopTitle : some View {
        VStack(spacing:24){
            HStack{
                Text("码力集市")
                    .font(.mt.title1.mtBlod(),textColor: .black)
                Spacer()
                
                Text(vm.selectFindModel.subTitle)
                    .font(.mt.body2.mtBlod(),textColor: .black)
                
                Button {
                    vm.isShowmtsheet.toggle()
                    vm.requestWithMenuList()
                } label: {
                    Image.mt.load(.Filter_list)
                        .foregroundColor(.red)
                }
            }
            HStack(spacing:48){
                VStack{
                    Text("32")
                        .font(.mt.title1.mtBlod() ,textColor: .black)
                    Text("在售")
                        .font(.mt.body3 ,textColor: .mt.gray_800)
                }
                
                VStack{
                    Text("294")
                        .font(.mt.title1.mtBlod() ,textColor: .black)
                    Text("顾问")
                        .font(.mt.body3 ,textColor: .mt.gray_800)
                }
                VStack{
                    Text("90")
                        .font(.mt.title1.mtBlod() ,textColor: .black)
                    Text("案例")
                        .font(.mt.body3 ,textColor: .mt.gray_800)
                }
            }
        }
        .mtCardStyle()
        .padding()
    }
    
    @ViewBuilder
    var productList : some View {
        //卡片宽度
        let cardWidth = (ScreenWidth() - 32 - 8 ) / 2
        //排序方式
        let columns =
        Array(repeating:  GridItem(.fixed(cardWidth)), count: 2)
        
        LazyVGrid(
            columns:columns,
            alignment: .center,
            spacing: 8,
            pinnedViews: .sectionFooters){
                // vm.proList
                ForEach(vm.proList) { item in
                    VStack(alignment: .leading, spacing: 8){
                        
                        KFImage(URL(string: item.productImg))
                            .resizable()
                            .scaledToFill()
                            .frame(width:cardWidth, height: cardWidth * 1.6)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 0)
                            )
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text(item.productName)
                                .font(.mt.body2.bold(),textColor: .black)
                            
                            Text(item.productPrice.toDouble.asCurrencyWith2Decimals())
                                .font(.mt.body2.bold(),textColor: .mt.accent_800)
                            
                            HStack {
                                KFImage(URL(string: item.authorHeadImgUrl))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .cornerRadius(15)
                                    .background(
                                        Circle()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.random)
                                    )
//                                    .MTImageBorder(color: .random, lineWidth: 0)
                                                            
                                Text(item.authorNickname)
                                    .font(.mt.body3, textColor: .mt.gray_500)
                                    .frame(height: 20)
                                
                                Spacer()
                                
                                Image.mt.load(.Visibility_Status_On)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.random)

                                Text(item.countBrowses)
                                    .font(.mt.body3, textColor: .mt.gray_500)
                            }
                        }
                        .padding()
                    }
//                    .mtCardStyle(insets: .init(horizontal: 0, vertical: 0))
                    .background(Color.white)
                    .clipShape(RoundedRectangle.init(cornerRadius: 12, style: .continuous))
                    .mtShadow(type: .shadowLow)
                }
            }
    }
}

//struct CodepowerView_Previews: PreviewProvider {
//    @ViewBuilder
//    static var previews: some View {
//        @State var isShow: Bool = false
//        CodepowerView(isShowmtsheet: $isShow)
//    }
//}
