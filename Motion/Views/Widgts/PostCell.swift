//
//  PostCell.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/16.
//

import SwiftUI

struct PostCell: View {
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Circle().fill(Color.random)
                .frame(size: .init(width: 52, height: 52))
                .background(Color.random)
                .clipShape(Circle())

            
            VStack(spacing: 0.0) {
                name
                
                Spacer.mt.min()
                
                team
                
                Spacer.mt.mid()

                Group {
                    Text("5 月 5 日星期三，序列号 15（SN15）的 Starship 成功完成了 SpaceX 对来自德克萨斯州 Starbase 的 Starship 原型机的第五次高空飞行测试。")
                        .font(.mt.body2, textColor: .mt.gray_900)
                        + Text("@ElonMusk")
                        .font(.mt.body2, textColor: .mt.accent_700)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer.mt.mid()

                Toolbar()
                    .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
    
    var name: some View {
        HStack(spacing: 2) {
            Text("姓名")
                .font(.mt.body2.mtBlod(), textColor: .black)
            Text("@usernickname")
                .font(.mt.body2, textColor: .mt.gray_600)

            Spacer()
        }
    }
    
    var team: some View {
        HStack(spacing: 2) {
            Text("武汉大学计算机社团")
                .font(.mt.caption2, textColor: .black)
            Text("#lsimai.short")
                .font(.mt.caption2, textColor: .mt.gray_600)
            Spacer()
        }
    }
}




extension PostCell {
    struct Toolbar: View {
        var body: some View {
            HStack {
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image.mt.load(.Add)
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text("123")
                            .font(.mt.caption1, textColor: .mt.gray_600)
                    }
                })
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image.mt.load(.Cached)
                            .resizable()
                            .frame(width: 12, height: 12)
                        Text("123")
                            .font(.mt.caption1, textColor: .mt.gray_600)
                    }
                })
                
                Spacer()

                Button(action: {
                    
                }, label: {
                    HStack {
                        Image.mt.load(.Penny)
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.mt.status_warnning)
                        Text("123")
                            .font(.mt.caption1, textColor: .mt.gray_600)
                    }
                })
            }
        }
    }
}




















struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostCell()
                .padding()
                .previewLayout(.sizeThatFits)
            
            PostCell.Toolbar()
                .previewLayout(.sizeThatFits)

        }
    }
}
