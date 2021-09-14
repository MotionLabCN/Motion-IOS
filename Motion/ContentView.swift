//
//  ContentView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/6.
//

import SwiftUI
import MotionComponents

struct ContentView: View {
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State var selectedKind = MTTabbar.Kind.home
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
   
                TabView(selection: $selectedKind) {
                    Rectangle()
                        .fill(Color.black)
                        .tag(MTTabbar.Kind.home)
    
                    Rectangle()
                        .fill(Color.blue)
                        .tag(MTTabbar.Kind.search)
    
                    Rectangle()
                        .fill(Color.yellow)
                        .tag(MTTabbar.Kind.team)
    
                    Rectangle()
                        .fill(Color.orange)
                        .tag(MTTabbar.Kind.message)
    
    
                }
                .edgesIgnoringSafeArea(.top)
                
                MTTabbar(selectedKind: $selectedKind)
            }
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("123")
            .navigationBarHidden(true)
        }
        
        
    }
}

struct MTTabbar: View {
    enum Kind: String, CaseIterable, Identifiable {
        var id: String { rawValue }
        case home, search, team, message
        
        var image: Image {
            switch self {
            case .home: return .mt.load(.Home)
            case .search: return .mt.load(.Search)
            case .team: return .mt.load(.Group)
            case .message: return .mt.load(.Mail)

            }
        }
    }
    
    @Binding var selectedKind: Kind

    var body: some View {
        HStack(spacing: 1.0, content: {
            ForEach(Kind.allCases) { kind in
                Button(action: {
                    withAnimation {
                        selectedKind = kind
                    }
                }, label: {
                    kind.image
                        .foregroundColor(selectedKind == kind ? .mt.accent_700 : .mt.gray_800)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .animation(Animation.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1))
                })
                .mtAnimation(isOverlay: false, scale: 0.8)
                
              
            }
            
        })
        .frame(height: 50)
        .padding(.bottom, SafeBottomArea())
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
    }
}
