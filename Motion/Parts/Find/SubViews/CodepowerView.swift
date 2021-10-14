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
                if vm.selectFindModel.subTitle.count > 0 {
                    Text(vm.selectFindModel.subTitle)
                        .font(.mt.body2.mtBlod(),textColor: .black)
                }else {
                    Text("全部")
                        .font(.mt.body2.mtBlod(),textColor: .black)
                }
                
                Button {
                    vm.isShowmtsheet.toggle()
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
                    VStack(alignment: .leading, spacing: 4){
                        
                        KFImage(URL(string: item.productImg))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Capsule(style: .continuous))
                            .cornerRadius(12)
                            .frame(width:cardWidth, height: cardWidth * 1.6)
                            .clipShape(
                //                Circle()// 圆角
                                RoundedRectangle(cornerRadius: 20) //自定义角度
                                
                //                Ellipse() // 椭圆
//                                Capsule(style: .circular)
                //                Circle()
                            )

//                            .background(
//                                RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                    .frame(width:cardWidth, height: cardWidth * 1.6)
//                                    .foregroundColor(.random)
//                            )
                            
                        
                        Text(item.productName)
                            .font(.mt.body2.bold(),textColor: .black)
                        Text(item.productPrice.toDouble.asCurrencyWith2Decimals())
                            .font(.mt.body2.bold(),textColor: .mt.accent_800)
                        Spacer(minLength: 10)
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
                            Text(item.authorNickname)
                                .font(.mt.body3, textColor: .mt.gray_500)
                            
                            Spacer()
                            
                        Text(item.countBrowses)
                            .font(.mt.body3, textColor: .mt.gray_500)
                        }
                    }
                }
            }
        
//        func fetchRemoteImage() //用来下载互联网上的图片
//            {
//                guard let url = URL(string: "http://hdjc8.com/images/logo.png") else { return } //初始化一个字符串常量，作为网络图片的地址
//                URLSession.shared.dataTask(with: url){ (data, response, error) in //执行URLSession单例对象的数据任务方法，以下载指定的图片
//                    if let image = UIImage(data: data!){
//                        self.remoteImage = image //当图片下载成功之后，将下载后的数据转换为图像，并存储在remoteImage属性中
//                    }
//                    else{
//                        print(error ?? "") //如果图片下载失败之后，则在控制台输出错误信息
//                    }
//                }.resume() //通过执行resume方法，开始下载指定路径的网络图片
//            }
    }

}

//struct CodepowerView_Previews: PreviewProvider {
//    @ViewBuilder
//    static var previews: some View {
//        @State var isShow: Bool = false
//        CodepowerView(isShowmtsheet: $isShow)
//    }
//}
