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

                Text("xxssss")
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
        HStack(spacing: 15.0) {
            Text("姓名")
            Text("@usernickname")
            Spacer()
        }
    }
    
    var team: some View {
        HStack(spacing: 15.0) {
            Text("姓名")
            Text("@usernickname")
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
                        Text("123")
                    }
                })
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image.mt.load(.Add)
                        Text("123")
                    }
                })
                
                Spacer()

                Button(action: {
                    
                }, label: {
                    HStack {
                        Image.mt.load(.Add)
                        Text("123")
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
