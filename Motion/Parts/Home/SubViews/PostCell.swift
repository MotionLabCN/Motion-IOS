//
//  PostCell.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/16.
//

import MotionComponents
import SwiftUI
import Kingfisher


struct PostCell: View {
    @State var isAlert = false
    
    let model: PostItemModel
    var didAlert: Block_T? = nil

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            MTAvatar(frame : 52) {}
            VStack(spacing: 0.0) {
                name
                
                Spacer.mt.custom(4)
                
                team
                
                Spacer.mt.mid()

                MTRichText(model.content)
                
                Spacer.mt.mid()
                
                if !model.pics.isEmpty {
                    CoversView(list: model.pics, layout: model.layout)
                        .frame(height: 200)
                }
               
                
                Spacer.mt.mid()

                toolbar
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)

    }
    
    var name: some View {
        HStack(spacing: 0) {
            Text(model.userVO.username)
                .font(.mt.body2.mtBlod(), textColor: .black)
            Text("@\(model.userVO.nickname)")
                .font(.mt.body2, textColor: .mt.gray_600)

            Spacer()
        }
    }
    
    var team: some View {
        HStack(spacing: 0) {
            Text("武汉大学计算机社团")
                .font(.mt.caption2, textColor: .black)
            Text("#lsimai.short")
                .font(.mt.caption2, textColor: .mt.gray_600)
            Spacer()
        }
    }
    
    
    var toolbar: some View {
        HStack {
           
            Button(action: {
                
            }, label: {
                HStack {
                    Image.mt.load(.Cached)
                        .mtSize(18, foregroundColor: .blue)
                        
                    Text("\(Int.random(in: 10...300))")
                        .font(.mt.caption1, textColor: .mt.gray_600)
                }
            })
            Spacer()
            Button(action: {
                
            }, label: {
                HStack {
                    Image.mt.load(.Penny)
                        .mtSize(18, foregroundColor: .mt.status_warnning)
                       
                    Text("\(Int.random(in: 10...300))")
                        .font(.mt.caption1, textColor: .mt.gray_600)
                }
            })
            Spacer()
            
            
            /// 假举报
            Button(action: {
            }, label: {
                HStack {
                    Image.mt.load(.More_horiz)
                        .mtSize(18, foregroundColor: .mt.gray_600)
                }
            })
                .contextMenu(
                    ContextMenu {
                        Button("举报", action: {
                            isAlert.toggle()
                        })
                    }
                )
                .alert(isPresented: $isAlert, content: {
                    Alert(title: Text("举报"), message: Text("是否举报该动态"), primaryButton: Alert.Button.cancel(Text("取消"), action: {
                        isAlert.toggle()
                    }), secondaryButton: Alert.Button.default(Text("确定"), action: {
                        didAlert?()
                        isAlert.toggle()
                        
                    }))
                })
               
            
            Spacer()
        }
    }
}


//MARK: - images
extension PostCell {
    struct CoversView: View {
        enum Layout {
            case one, oneByOne, oneByTwo, twoByTwo
        }

        var list: [String]
        var layout: Layout
        
        private let spacing: CGFloat = 4
        private let maxHeight: CGFloat = 400
        var body: some View {
            HStack(spacing: spacing) { // 最外层H start
                switch layout {
                case .one:
                    KFImage(list[0].url)
                        .resizable()
                        .placeholder({
                            Color.mt.gray_800
                        })
                        .frame(maxWidth: .infinity, maxHeight: maxHeight)

                case .oneByOne:
                    KFImage(list[0].url)
                        .resizable()
                        .placeholder({
                            Color.mt.gray_800
                        })
                        .frame(maxWidth: .infinity, maxHeight: maxHeight)
                    
                    KFImage(list[1].url)
                        .resizable()
                        .placeholder({
                            Color.mt.gray_800
                        })
                        .frame(maxWidth: .infinity, maxHeight: maxHeight)
                case .oneByTwo:
                    KFImage(list[0].url)
                        .resizable()
                        .placeholder({
                            Color.mt.gray_800
                        })
                        .frame(maxWidth: .infinity, maxHeight: maxHeight)

                    VStack(spacing: spacing)  {
                        KFImage(list[1].url)
                            .resizable()
                            .placeholder({
                                Color.mt.gray_800
                            })
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                        KFImage(list[2].url)
                            .resizable()
                            .placeholder({
                                Color.mt.gray_800
                            })
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                    }
                case .twoByTwo:
                    VStack(spacing: spacing)  {
                        KFImage(list[0].url)
                            .resizable()
                            .placeholder({
                                Color.mt.gray_800
                            })
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                        KFImage(list[1].url)
                            .resizable()
                            .placeholder({
                                Color.mt.gray_800
                            })
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                    }
                    
                    VStack(spacing: spacing)  {
                        KFImage(list[2].url)
                            .resizable()
                            .placeholder({
                                Color.mt.gray_800
                            })
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                        KFImage(list[3].url)
                            .resizable()
                            .placeholder({
                                Color.mt.gray_800
                            })
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                    }
                }
            } // 最外层H end
            .cornerRadius(8)
            
        }
    }
}



















struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostCell(model: .init())
//                .padding()
//                .previewLayout(.sizeThatFits)
            
//            PostCell.PostToolBar()
//                .previewLayout(.sizeThatFits)

//            PostCell.CoversView(layout: .one)
//                .previewLayout(.fixed(width: 415, height: 100))
//
//            PostCell.CoversView(layout: .oneByOne)
//                .previewLayout(.fixed(width: 415, height: 100))
//
//            PostCell.CoversView(layout: .oneByTwo)
//                .previewLayout(.fixed(width: 415, height: 200))
//
//            PostCell.CoversView(layout: .twoByTwo)
//                .previewLayout(.fixed(width: 415, height: 200))

        }
    }
}
