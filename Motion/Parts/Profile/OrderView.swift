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

struct OrderList: View {
    
    @StateObject private var vm = OrderVM()
    
    var body: some View {
        
        List{
            ForEach(vm.codeItems) { item in
                OrderItemCell(item:item)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text("订单"))
        .mtTopProgress(vm.isCodeLoading, usingBackgorund: false)
//        .mtToast(isPresented: $vm.isShowToast, text: vm.toastText)
    }
}
