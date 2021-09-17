//
//  PostCell.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/16.
//

import MotionComponents

struct PostCell: View {
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Circle().fill(Color.random)
                .frame(size: .init(width: 52, height: 52))
                .background(Color.random)
                .clipShape(Circle())

            
            VStack(spacing: 0.0) {
                name
                
                Spacer.mt.custom(4)
                
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
                
                CoversView(layout: .one)
                    .frame(height: 200)
                
                Spacer.mt.mid()

                Toolbar()

            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
    
    var name: some View {
        HStack(spacing: 0) {
            Text("赵翔宇")
                .font(.mt.body2.mtBlod(), textColor: .black)
            Text("@usernickname")
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
}

//MARK: - toolbar
extension PostCell {
    
    struct Toolbar: View {
        var body: some View {
            HStack {
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image.mt.load(.Comment)
                            .mtSize(18, foregroundColor: .mt.gray_600)

                        Text("12")
                            .font(.mt.caption1, textColor: .mt.gray_600)
                    }
                })
                Spacer()
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image.mt.load(.Cached)
                            .mtSize(18, foregroundColor: .blue)
                            
                        Text("324")
                            .font(.mt.caption1, textColor: .mt.gray_600)
                    }
                })
                Spacer()
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image.mt.load(.Penny)
                            .mtSize(18, foregroundColor: .mt.status_warnning)
                           
                        Text("77")
                            .font(.mt.caption1, textColor: .mt.gray_600)
                    }
                })
                Spacer()
            }
        }
    }
}


//MARK: - images
extension PostCell {
    struct CoversView: View {
        enum Layout {
            case one, oneByOne, oneByTwo, twoByTwo
        }
        typealias ModelType = Int
        var list = [ModelType]()
        var layout: Layout
        
        private let spacing: CGFloat = 4
        private let maxHeight: CGFloat = 400
        var body: some View {
            HStack(spacing: spacing) { // 最外层H start
                switch layout {
                case .one:
                    Image.mt.load(.ATM)
                        .frame(maxWidth: .infinity, maxHeight: maxHeight)
                        .background(Color.random)
                    
                case .oneByOne:
                    Image.mt.load(.ATM)
                        .frame(maxWidth: .infinity, maxHeight: maxHeight)
                        .background(Color.random)
                    Image.mt.load(.ATM)
                        .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                case .oneByTwo:
                    Image.mt.load(.ATM)
                        .frame(maxWidth: .infinity, maxHeight: maxHeight)
                        .background(Color.random)
                    VStack(spacing: spacing)  {
                        Image.mt.load(.ATM)
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                        Image.mt.load(.ATM)
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                    }
                case .twoByTwo:
                    VStack(spacing: spacing)  {
                        Image.mt.load(.ATM)
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                        Image.mt.load(.ATM)
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                    }
                    
                    VStack(spacing: spacing)  {
                        Image.mt.load(.ATM)
                            .frame(maxWidth: .infinity, maxHeight: maxHeight)                        .background(Color.random)
                        Image.mt.load(.ATM)
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
            PostCell()
                .padding()
                .previewLayout(.sizeThatFits)
            
            PostCell.Toolbar()
                .previewLayout(.sizeThatFits)

            PostCell.CoversView(layout: .one)
                .previewLayout(.fixed(width: 415, height: 100))
            
            PostCell.CoversView(layout: .oneByOne)
                .previewLayout(.fixed(width: 415, height: 100))
            
            PostCell.CoversView(layout: .oneByTwo)
                .previewLayout(.fixed(width: 415, height: 200))
            
            PostCell.CoversView(layout: .twoByTwo)
                .previewLayout(.fixed(width: 415, height: 200))

        }
    }
}
