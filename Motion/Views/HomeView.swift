//
//  HomeView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/15.
//

import SwiftUI
import MotionComponents

public struct MTNavbarViewModifier<MTContent: View, L: View, R: View>: ViewModifier {
    let mtContent: MTContent
    var leading: L
    var trailing: R
    
    public init(@ViewBuilder content: () -> MTContent, @ViewBuilder leading: () -> L, @ViewBuilder trailing: () -> R) {
        self.mtContent = content()
        self.leading = leading()
        self.trailing = trailing()
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack {
                ZStack {
                    BlurView()
                        .ignoresSafeArea( edges: .top)
                        .frame(height: NavBarH)
                                           
                    //leading trailing
                    HStack(spacing: 0, content: {
                        leading
                        Spacer()
                        trailing
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: NavBarH)
                    .padding(.horizontal, 16)

                    // titleView
                    HStack(spacing: 0, content: {
                        mtContent
                    })
                    .frame(maxWidth: .infinity)
                    .frame(height: NavBarH)
                }
                
                Spacer(minLength: 0)
            }
            
        }
    }
}

public extension View {
    func mtNavbar<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            EmptyView()
        }, trailing: {
            EmptyView()
        }))
    }
    
    func mtNavbar<Content: View, L: View>(@ViewBuilder content: () -> Content, @ViewBuilder leading: () -> L) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            leading()
        }, trailing: {
            EmptyView()
        }))
    }

    func mtNavbar<Content: View, R: View>(@ViewBuilder content: () -> Content, @ViewBuilder trailing: () -> Content) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            EmptyView()
        }, trailing: {
            trailing()
        }))
    }

    func mtNavbar<Content: View, L: View, R: View>(@ViewBuilder content: () -> Content, @ViewBuilder leading: () -> L, @ViewBuilder trailing: () -> R) -> some View {
        modifier(MTNavbarViewModifier(content: content, leading: {
            leading()
        }, trailing: {
            trailing()
        }))
    }
}

//MARK: - 首页
struct HomeView: View {

    @StateObject var vm = PostVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0.0) {
                Spacer.mt.navbar()
                header
                Divider.mt.defult()
                
                main
            }
        }
//        .overlay(
//            placeholder
//                .padding(.top, 100)
//        )
        .mtNavbar(content: {
            Image.mt.load(.Logo)
                .resizable()
                .frame(size: .init(width: 33, height: 33))
        }, leading: {
            Circle()
                .fill(Color.black)
                .frame(size: .init(width: 33, height: 33))
            
        }
        , trailing: {
            Image.mt.load(.Map_place)
        })
        
        .mtAttatchTabbarSpacer()
        
    }
    
}

extension HomeView {
    var header: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack(spacing: 20, content: {
                ForEach(1...100, id: \.self) { count in
                HomeHeaderItemView()
                    
                }
            })
            .padding()
        })
    }
    var main: some View {
        VStack {
            ForEach(1...10, id: \.self) { count in
                PostCell()
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                Divider.mt.defult()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    var placeholder: some View {
        VStack(spacing: 20) {
            MTDescriptionView(title: "尚未连接任何人", subTitle: "Motion是创造者们加速他们伟大创造的地方。科技、艺术、制造业工作者们在这里见面，组成协作小队。")
            
            Button(action: {
                
            }, label: {
                Text("查找朋友")
                    .modifier(MTButtonStyleModifier(style: .mainDefult(isEnable: true), customBackground: true))
                    .frame(width: 125)
                    .background(
                        Color.mt.accent_700.clipShape(Capsule())
                    )
            })
            .mtAnimation()
        }
    }
    
}





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}













//MARK: - 圆形边框

struct MTImageBorder: ViewModifier {
    let color: Color
    let lineWidth: CGFloat
    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .strokeBorder(color, lineWidth: lineWidth)
            )
    }
}
public extension View {
    func mtBoderCircle(_ color: Color = .white, lineWidth: CGFloat = 3) -> some View {
        modifier(MTImageBorder(color: color, lineWidth: lineWidth))
    }
}

