//
//  HomeView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/15.
//

import SwiftUI
import MotionComponents


//MARK: - 首页
struct HomeView: View {

    @StateObject var vm = PostVM()
    
    @State private var isShowPlaceholder = false
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0.0) {
                Spacer.mt.navbar()
                header
                Divider.mt.defult()
                main
            }
        }
        .overlay(
            Group {
                if isShowPlaceholder {
                    placeholder
                        .padding(.top, 100)
                }
            }
        )
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
        LazyVStack {
            ForEach(1...119, id: \.self) { count in
                NavigationLink {
                    Text("待完善")
                } label: {
                    VStack {
                        PostCell()
                            .padding(.horizontal)
                            .padding(.vertical, 8)

                        Divider.mt.defult()
                    }
                }
                .mtLinkStyle()
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




//MARK: - 可抽出去
struct MTNavigationLinkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct MTNavigationLinkrotation3DButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed
        
        configuration.label
            .rotation3DEffect(Angle(degrees: isPressed ? 7 : 0), axis: (x: 0, y: 1, z: 0), anchor: .leading)
            .animation(.spring())
    }
}

public extension NavigationLink {
    enum MTLinkStyle {
        case system, normal, rotation3D
    }
    
    @ViewBuilder
    func mtLinkStyle(_ style: MTLinkStyle = .rotation3D) -> some View {
        switch style {
        case .system: self
        case .normal: buttonStyle(MTNavigationLinkButtonStyle())
        case .rotation3D: buttonStyle(MTNavigationLinkRotation3dButtonStyle())
            
        }
    }
}

