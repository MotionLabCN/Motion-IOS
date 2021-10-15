//
//  OrderView.swift
//  Motion
//
//  Created by Liseami on 2021/10/14.
//

import SwiftUI
import MotionComponents

struct OrderView: View {
    @Environment(\.presentationMode) var persentationMode
    
    @StateObject private var vm = OrderVM()
    
    @State var tabIndex : Int = 1
    var body: some View {
        
        NavigationView{
            
            List{
                Section {
                    
                    if tabIndex == 1{
                        //消费订单
                        consumptionOrder
                    }else{
                        //收入订单
                        incomeOrder
                    }
                }header: {
                    
                    Picker(selection: $tabIndex, label: Text("Picker")) {
                        Text("消费订单").tag(1)
                        Text("收益订单").tag(2)
                    }.pickerStyle(.segmented)
                        .padding(.bottom,42)

                }
            }
            .listStyle(.grouped )
            .navigationBarTitle(Text("我的订单"))
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: closeBtn)
    }
        .accentColor(Color.mt.accent_purple)
}
    
    @ViewBuilder
    var incomeOrder : some View {
        NavigationLink {
            Label {Text("代码收益")} icon: {
                Image.mt.load(.Build)
            }
        } label: {
            Label {Text("代码收益")} icon: {
                Image.mt.load(.Build)
            }
        }
        
        NavigationLink {
            Label {Text("储存收益")} icon: {
                Image.mt.load(.Pie_chart)
            }
        } label: {
            Label {Text("储存收益")} icon: {
                Image.mt.load(.Pie_chart)
            }
        }
    }
        
    
    @ViewBuilder
    var consumptionOrder : some View {
        NavigationLink {
            OrderList()
                .environmentObject(vm)
        } label: {
            Label {Text("代码订单")} icon: {
                Image.mt.load(.Build)
            }
        }
        
        NavigationLink {
            Label {Text("储存订单")} icon: {
                Image.mt.load(.Pie_chart)
            }
        } label: {
            Label {Text("储存订单")} icon: {
                Image.mt.load(.Pie_chart)
            }
        }
    }
    var closeBtn : some View {
        Button {
            self.persentationMode.wrappedValue.dismiss()
        } label: {
            Image.mt.load(.Close)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .foregroundColor(Color.black)
        .padding(.all,4)
        .background(Color.mt.gray_100)
        .clipShape(Circle())
        .frame(maxWidth:.infinity,alignment: .trailing)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
//        OrderView()
        OrderList()
    }
}

//struct OrderCell: View {
//
//    var body: some View {
//        HStack(alignment: .top,spacing: 20){
//            Image("peers").resizable()
//                .frame(width: 44, height: 44)
//                .scaledToFit()
//            VStack(alignment: .leading,spacing:12){
//                HStack(alignment: .top){
//                    Text("网站后台权限管理系统")
//                        .font(.mt.body1.mtBlod(), textColor: .mt.gray_900)
//                    Spacer()
//                    Text("待支付")
//                        .font(.mt.body3, textColor: .mt.gray_900)
//
//                }
//                Text("价格")
//
//                HStack(alignment: .top){
//                    Text("下单时间：2021-10-09 10:53:44")
//                    Spacer()
//                    Text("¥329.99")
//                }
//
//                Text("订单编号:20211009000003010520515216543744")
//                    .lineLimit(1)
//
//
//            }
//
//
//
//        }.padding()
//    }
//}

struct OrderList: View {
    
    @EnvironmentObject var vm: OrderVM
    
    var body: some View {
        
        List{
            ForEach(vm.codeItems) { item in
                OrderCell
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("订单"))

    }
    
    //MArk
    var OrderCell: some View {
        HStack(alignment: .top,spacing: 20){
            Image("peers").resizable()
                .frame(width: 44, height: 44)
                .scaledToFit()
            VStack(alignment: .leading,spacing:12){
                HStack(alignment: .top){
                    Text("网站后台权限管理系统")
                        .font(.mt.body1.mtBlod(), textColor: .mt.gray_900)
                    Spacer()
                    Text("待支付")
                        .font(.mt.body3, textColor: .mt.gray_900)
                    
                }
                Text("价格")
                
                HStack(alignment: .top){
                    Text("下单时间：2021-10-09 10:53:44")
                    Spacer()
                    Text("¥329.99")
                }
           
                Text("订单编号:20211009000003010520515216543744")
                    .lineLimit(1)
            }
        }.padding()
    }
}
