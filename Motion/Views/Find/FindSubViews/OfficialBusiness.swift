//
//  OfficialBusiness.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI

struct OfficialBusiness: View {
    var body: some View {
        
        HStack{
            Image.mt.load(.Savings_bag)
                .resizable()
                .frame(width: 44, height: 44)
                .padding(.all,24)
            VStack(alignment: .leading, spacing: 4){
                Text("认证远程面试官")
                    .font(.mt.title2.mtBlod(),textColor: .black)
                Text("成为在线面试官，为小微企业提供远程技术面试服务，在线赚取服务费。")
                    .font(.mt.body2,textColor: .mt.gray_600)
            }
        }.padding()
        
       
        
    }
}

struct OfficialBusiness_Previews: PreviewProvider {
    static var previews: some View {
        OfficialBusiness()
    }
}
