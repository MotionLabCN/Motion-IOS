//
//  NextView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/14.
//

import SwiftUI

struct NextView: View {
    @EnvironmentObject var uiStateObj: AppState.TabbarState
    
    @State var isShowToast = false
    
    @State var isShow = true
    var body: some View {
        NavigationView {
            Button {
                isShowToast.toggle()
            } label: {
                Image.mt.load(.ATM)
            }

            List(0..<10) { _ in
                Text("123")
            }
        }
//        .mtFullScreenCover($isShow)
        .fullScreenCover(isPresented: $isShowToast) {
            
        } content: {
            VStack {
                Circle()
                    .fill(Color.red)
                    .frame(width: 100, height: 100)
                    .overlay(
                        Text("123")
                            .overlay(
                                Text("444")
                                    .background(BackgroundCleanerView())
                            )
//                            .background(BackgroundCleanerView())
                    )

                Spacer()

            }
        }

      
        
    }
}


struct BackgroundCleanerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct MTFullScreenCoverViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
       
        ZStack(alignment: .bottom) {
//            rootView
            content
            Rectangle()
                .fill(Color.gray)
                
            VStack {
                Image(systemName: "chevron.up")
                    .padding(.top)
                Text("Sing up")
                 
//                Spacer()
            }
//                .frame(height: 100)
        }
    }

}

public extension View {
//    public func fullScreenCover<Item, Content>(item: Binding<Item?>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping (Item) -> Content) -> some View where Item : Identifiable, Content : View
//
//    public func fullScreenCover<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View
    func mtFullScreenCover(_ isPresented: Binding<Bool>) -> some View {
        modifier(MTFullScreenCoverViewModifier(isPresented: isPresented))
    }
}

















struct NextView_Previews: PreviewProvider {
    static var previews: some View {
        NextView()
            .environmentObject(AppState.TabbarState())
    }
}
