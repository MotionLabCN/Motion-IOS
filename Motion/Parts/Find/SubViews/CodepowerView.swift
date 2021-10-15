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
    
    @State private var isPushWebView: Bool = false
    
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
                
                filter
                
                if vm.proList.count > 0 {
                    productList
                } else {
                    
                    Text("暂无数据")
                        .font(.mt.body1.mtBlod(),textColor: .mt.gray_600)
                        .padding(.horizontal,16)
                        .frame(height:200)
                }
            }
        }
        .frame(width: ScreenWidth())
        .onAppear {
            print("22222")
        }
        .mtRegisterRouter(isActive: $isPushWebView) {
//            MTWebView(urlString: "https://baidu.com")
            MTWebView(urlString: vm.detailWebUrl)
        }
    }

   
    
    var title : some View {
        VStack(spacing:6){
            Text("技术方案在这里流通与落地")
                .font(.mt.largeTitle.mtBlod() ,textColor: .black)
                .multilineTextAlignment(.center)
                .padding(.horizontal,70)
            
            Text("中小企业以灵活用工的方式落地现代技术方案。")
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
            HStack{
                VStack(spacing:4){
                    Text("\(vm.proList.count)")
                        .kerning(2)
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                    Text("在售方案")
                        .font(.mt.body3,textColor: .mt.gray_400)
                }
                Spacer()
                Capsule(style: .continuous).frame(width: 0.5).foregroundColor(.mt.gray_400)
                    .opacity(0.2)
                Spacer()
                VStack(spacing:4){
                    Text("\(vm.proList.count)")
                        .kerning(2)
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                    Text("顾问")
                        .font(.mt.body3,textColor: .mt.gray_400)
                }
              
                Spacer()
                Capsule(style: .continuous).frame(width: 0.5).foregroundColor(.mt.gray_400)
                    .opacity(0.2)
                Spacer()
                VStack(spacing:4){
                    Text("\(vm.proList.count)")
                        .kerning(2)
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                    Text("近期成交")
                        .font(.mt.body3,textColor: .mt.gray_400)
                }
            }
        .padding(.horizontal,32)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .black.opacity(0.03), radius: 16, x: 0, y: 8)
        .shadow(color: .black.opacity(0.12), radius: 32, x: 0, y: 12)
        .padding()
    }
    
    @ViewBuilder
    var filter : some View {
        HStack{
            Text("语言:\(vm.selectLang)")
                .font(.mt.body3.mtBlod(),textColor: .black)
            
            Text("技术:\(vm.selectTec)")
                .font(.mt.body3.mtBlod(),textColor: .black)
            
            Text("价格:\(vm.selectPrice)")
                .font(.mt.body3.mtBlod(),textColor: .black)
            
            Spacer()
            
            Button {
                vm.isShowmtsheet.toggle()
                vm.requestWithMenuList()
            } label: {
                Image.mt.load(.Filter_list)
                    .foregroundColor(.red)
            }
        }.padding(.horizontal)
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
            pinnedViews: .sectionFooters) {
                
                // vm.proList
                ForEach(vm.proList) { item in
                    
                    //
                    VStack(alignment: .leading, spacing: 4){
                        
                        KFImage(URL(string: item.productImg))
                            .placeholder {
                                Color.white
                                    .overlay(  Image.mt.load(.Share_Android)
                                                .resizable()
                                                .foregroundColor(.mt.gray_400)
                                                .scaledToFit()
                                                .frame(width: 24, height: 24)
                                    )
                                   }
                            .resizable()
                            .scaledToFill()
                            .frame(width:cardWidth, height: cardWidth * 1.6)
                    .mtCardStyle(insets: .init(horizontal: 0, vertical: 0))
                    .background(Color.white)
                    .clipShape(RoundedRectangle.init(cornerRadius: 12, style: .continuous))
                    .mtShadow(type: .shadowLow)
                    .onTapGesture {
                        isPushWebView = true
                        // 暂时token
                        let token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcnQiOiIxNjM0MjYwNDYwOTQ3IiwidXNlcl9pZCI6ImE3NTdiZDU5LWRhMTUtNDM2OS1hNzViLWRlNDI4NWJhZGQ4YyIsInNjb3BlIjpbImFsbCJdLCJtb2JpbGUiOiIxNTUyNzg2NDE2MiIsImV4cCI6MTYzNDI4OTI2MCwiZGV2aWNlIjoiUEMiLCJqdGkiOiI0ZGZlY2FkYi0zYmZlLTRmMjgtYmQyZC1jMDRlM2U4Mzg2ZDkiLCJjbGllbnRfaWQiOiJ0bnRsaW5raW5nIn0.OIVfewKTZKNJ4mIyMq1AYY3ybleOpNF0HcVAp7mweehJdgPTTDEmAKosAIt-IbBOadiieMCVGwGrqwyVdU1kHn8K8y-O2ZREmG32VVXSfvmzAbPhnpeamNnTC_daYflpCpZzd6CENjvHADyAr8tpW3A2kEnyeB5qb-8IJmI0esjq_olIOcGdSaw9aWdxYIKcB8t987mnZJmtOttisEehmRNKOAABCkzzb3wEbk2IGOcnOs6Wf3HSW6SgMyfDaKeolWg7DIpZB-HmPA0gHzNDZKjvd4nam2lJcMMcCp4GlCKD59zEFgOcfWBxi7pm1XJaQM7LEZw7KNhF4JCx3h5yyA"
                        vm.detailWebUrl = "https://ttchain.tntlinking.com/codeForce/codeDetails/\(item.productId)?info=\(token)"
                    }
                        Text(item.productName)
                            .font(.mt.body1.bold(),textColor: .black)
                            .lineLimit(2)
                        HStack(spacing:4){
                            Text(item.productPrice.toDouble.asCurrencyWith2Decimals())
                                .font(.mt.body2.bold(),textColor: .mt.accent_800)
                            Spacer()
                        }
                    }
                
                   
                }
            }
    }
}

struct CodepowerView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CodepowerView()
    }
}
//
//
//HStack {
//    KFImage(URL(string: item.authorHeadImgUrl))
//        .resizable()
//        .placeholder {
//            Image.mt.load(.Person)
//                .resizable()
//                .foregroundColor(.mt.gray_500)
//                .scaledToFit()
//                .frame(width: 24, height: 24)
//                .clipShape(Capsule(style: .continuous))
//        }
//        .aspectRatio(contentMode: .fit)
//        .frame(width: 30, height: 30)
//        .cornerRadius(15)
//        .background(
//            Circle()
//                .frame(width: 30, height: 30)
//                .foregroundColor(.mt.gray_200)
//        )
//    Text(item.authorNickname)
//        .font(.mt.body3, textColor: .mt.gray_500)
//        .frame(height: 20)
//
//    Spacer()
//}

//
//VStack(alignment: .leading, spacing: 8){
//    Text(item.productName)
//        .font(.mt.body1.bold(),textColor: .black)
//        .lineLimit(2)
//    HStack(spacing:4){
//        Text(item.productPrice.toDouble.asCurrencyWith2Decimals())
//            .font(.mt.body2.bold(),textColor: .mt.accent_800)
//        Spacer()
//        Image.mt.load(.Visibility_Status_On)
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: 12, height: 12)
//            .foregroundColor(.mt.gray_500)
//        Text(item.countBrowses)
//            .font(.mt.body2, textColor: .mt.gray_500)
//    }
//}
//.padding()

//Image.mt.load(.Visibility_Status_On)
//    .resizable()
//    .aspectRatio(contentMode: .fit)
//    .frame(width: 14, height: 14)
//    .foregroundColor(.mt.gray_500)
//Text(item.countBrowses)
//    .font(.mt.body2, textColor: .mt.gray_500)
