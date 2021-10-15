//
//  OrderItemCell.swift
//  Motion
//
//  Created by Beck on 2021/10/15.
//

import SwiftUI
import Kingfisher

struct OrderItemCell: View {
    let item : OrderModel
    var body: some View {
        HStack(alignment: .top,spacing: 20){
            KFImage(URL(string: item.fkProductImage))
                .placeholder {
                    Color.white
                        .overlay(  Image.mt.load(.Share_Android)
                                    .resizable()
                                    .foregroundColor(.mt.gray_400)
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                        )
                       }
                .frame(width: 44, height: 44)
                .scaledToFit()
            VStack(alignment: .leading,spacing:12){
                HStack(alignment: .top){
                    Text(item.fkProductName)
                        .font(.mt.body1.mtBlod(), textColor: .mt.gray_900)
                    Spacer()
                    Text(item.orderStateString)
                        .font(.mt.body3, textColor: .mt.gray_900)
                }
                Text("价格")
                Text("支付方式:\(item.payStyle)")
                HStack(alignment: .top){
                    Text("下单时间：\(item.cstCreate)")
                    Spacer()
                    Text(item.totalAmount.toDouble.asCurrencyWith2Decimals())
                }
           
                Text("订单编号:\(item.outTradeNo)")
                    .lineLimit(1)
            }
        }.padding()
    }
}

struct OrderItemCell_Previews: PreviewProvider {
    static var previews: some View {
        OrderItemCell(item:.init())
    }
}
