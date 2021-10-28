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
    //@Binding var isShowmtsheet: Bool
    @State  var offsetAnimation  : Bool = false
    
    @State private var isPushWebView: Bool = false
    @State private var isPublishProduct: Bool = false
    @State private var product1 : Dictionary = ["":""]
    @State private var product2 : Dictionary = ["":""]
    
    let animation = Animation.linear(duration: 10).repeatForever(autoreverses: true)
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            
            VStack(spacing:12){
                
                Spacer().frame(width: 0, height: 24)
                
                title
                
                Spacer().frame(width: 0, height: 24)
                
                codePowerCard
                
                Spacer().frame(width: 0, height: 24)
                
                Button("上架技术方案"){
                    //                    let token = ""
                    isPublishProduct = true
                    vm.publishProductWebUrl = "https://ttchain.tntlinking.com/codeForce/publishProduct" // 暂时没有添加token 需要登录
                }
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
            Spacer.mt.tabbar()
        }
        .onChange(of: vm.proList.count, perform: { newValue in
            product1 = [vm.proList[0].productImg:vm.proList[0].productName]
            product2 = [vm.proList[1].productImg:vm.proList[1].productName]
        })
        .frame(width: ScreenWidth())
        .mtRegisterRouter(isActive: $isPushWebView) {
            MTWebView(urlString: vm.detailWebUrl)
        }
        .mtRegisterRouter(isActive: $isPublishProduct) {
            MTWebView(urlString: vm.publishProductWebUrl)
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
                .multilineTextAlignment(.center)
                .lineSpacing(6)
                .padding(.horizontal,56)
        }
    }
    
    struct CodePowerCard: View {
        var imageurl : String = "IMG_5847"
        let name : String
        let level : Int = 5
        
        var body: some View {
            
            let w = ScreenWidth() / 3
            VStack{
                KFImage(URL(string: imageurl))
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
                    .frame(width:w)
                    .clipShape( RoundedRectangle(cornerRadius: 16, style: .continuous))
                HStack{
                    Text(name)
                        .font(.mt.body2.mtBlod(), textColor: .mt.gray_900)
                        .frame(maxWidth:.infinity,alignment: .leading)
                    Spacer()
                    Image.mt.load(.ATM).foregroundColor(.random)
                }
                .padding(.vertical)
            }
            .padding(.all,12)
            .background(  ZStack{
                Color.white.opacity(0.8)
                BlurView(style: .regular)
            } )
            .clipShape( RoundedRectangle(cornerRadius: 12, style: .continuous))
            .frame(width:w )
            .shadow(color: .black.opacity(0.14), radius: 16, x: 0, y: 6)
            .shadow(color: .black.opacity(0.07), radius: 24, x: 0, y: 6)
            
            
        }
    }
    
    
    @ViewBuilder
    var codePowerCard : some View {
        
        ZStack{
            CodePowerCard(imageurl: product2.keys.first!, name: product2.values.first!)
                .rotationEffect(Angle(degrees: -9), anchor: .bottom)
                .offset(x:-32)
            CodePowerCard(imageurl: product2.keys.first!, name: product2.values.first!)
                .rotationEffect(Angle(degrees: 9), anchor: .bottom)
                .offset(x:32)
            CodePowerCard(imageurl: product1.keys.first!, name: product1.values.first!)
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
                .font(.mt.body2.mtBlod(),textColor: .black)
            
            Text("技术:\(vm.selectTec)")
                .font(.mt.body2.mtBlod(),textColor: .black)
            
            Text("价格:\(vm.selectPrice)")
                .font(.mt.body2.mtBlod(),textColor: .black)
            
            Spacer()
            
            Button {
                vm.isShowmtsheet.toggle()
                //                vm.requestWithMenuList()
            } label: {
                Image.mt.load(.Filter_list)
                    .foregroundColor(.red)
            }
        }.padding(.horizontal)
    }
    
    @ViewBuilder
    var productList : some View {
        //卡片宽度
        let cardWidth = (ScreenWidth() - 32 - 20 ) / 2
        //排序方式
        let columns = Array(repeating: GridItem(.fixed(cardWidth)), count: 2)
        
        LazyVGrid(
            columns:columns,
            alignment: .center,
            spacing: 20,
            content: {
                // vm.proList
                ForEach(vm.proList) { item in
                    //
                    VStack(alignment: .leading, spacing: 4){
                        KFImage(URL(string: item.productImg))
                            .placeholder {
                                Color.white
                                    .overlay(Image.mt.load(.Share_Android)
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
                                let token = UserManager.shared.token
                                vm.detailWebUrl = "https://ttchain.tntlinking.com/codeForce/codeDetails/\(item.productId)?info=\(token)"
                            }
                        Spacer(minLength: 8)
                        Text(item.productName)
                            .font(.mt.body1.mtBlod(),textColor: .black)
                            .lineLimit(1)
                        HStack(spacing:4){
                            Text(item.productPrice.toDouble.mtCurrencyWith2Decimals())
                                .font(.mt.body2.mtBlod(),textColor: .mt.accent_800)
                            Spacer()
                        }
                    }
                }
            })
    }
}

struct CodepowerView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CodepowerView()
    }
}


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
//        .font(.mt.body1.mtBold(),textColor: .black)
//        .lineLimit(2)
//    HStack(spacing:4){
//        Text(item.productPrice.toDouble.asCurrencyWith2Decimals())
//            .font(.mt.body2.mtBold(),textColor: .mt.accent_800)
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

