
//  HomeHeaderItemView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/16.
//

import SwiftUI


class HomeHeaderItemVM: ObservableObject {
    @Published var isAnimation = false
    
    init() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) { [weak self] in
            self?.isAnimation = true
        }
    }
}
struct HomeHeaderItemView: View {
    //@StateObject var vm = HomeHeaderItemVM()
    @State var isAnimation = false
    var body: some View {
        VStack(spacing: 3.0) {
            HStack(spacing: 4.0) {
                HStack(spacing: 0.0) {
                    Group {
                        Circle()
                            .fill(Color.red)
                            .mtFrame(width: 44, height: 44)
                            .mtBoderCircle()
                        Circle()
                            .fill(Color.random)
                            .mtFrame(width: 44, height: 44)
                            .mtBoderCircle()
                            .padding(.leading, -20)
                    }
                    .padding(.all, 2)
                }
                Text("+99")
                    .font(.mt.body2.mtBlod(), textColor: .white)
                    .padding(.trailing, 16)
            }
            .background(Color.mt.accent_purple.clipShape(Capsule()))
            .overlay(
                Image.mt.load(.Logo)
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.white)
                    .frame(width: 18, height: 18)
                    .background(
                        Color.mt.accent_purple
                            .clipShape(Circle())
                            .mtBoderCircle(lineWidth: 2)
                    )
                    .offset(x: -2, y: -1.0)
                , alignment: .bottomTrailing)
            .padding(.all, 2)
            .background(
                ZStack {
                    Color.mt.accent_purple.opacity(0.3)
                        .clipShape(Capsule())
                    
                    Color.mt.accent_purple.opacity(0.3)
                        .clipShape(Capsule())
                        .scaleEffect(isAnimation ? 1.2: 1)
                        .opacity(isAnimation ? 0 : 1)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false))

                }
            )
            .padding(.all, 2)
            .background(
                ZStack {
                    Color.mt.accent_purple.opacity(0.1)
                        .clipShape(Capsule())
                    
                    Color.mt.accent_purple.opacity(0.1)
                        .clipShape(Capsule())
                        .scaleEffect(isAnimation ? 1.2: 1)
                        .opacity(isAnimation ? 0 : 1)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: false))

                }
                
            )
            
            Text("天天数链研发小队")
                .font(.mt.caption1, textColor: .mt.gray_800)
        }
        .onAppear {
            isAnimation = true
        }
   
    }
}


struct HomeHeaderItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderItemView()
            .previewLayout(.sizeThatFits)
    }
}
