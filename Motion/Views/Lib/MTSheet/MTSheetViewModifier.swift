//
//  MTSheetViewModifier.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/23.
//
import SwiftUI
import MotionComponents



public extension View {
    func mtSheet<Content>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        modifier(
            MTSheetNoramlViewModifier(isPresented: isPresented, onDismiss: onDismiss, mtContent: content)
        )
    }
    
    @ViewBuilder
    func mtSheet<Content>(isPresented: Binding<Bool>, isCanDrag: Bool, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Content) -> some View where Content : View {
        if isCanDrag {
            modifier(
                MTSheetDragViewModifier(isPresented: isPresented, onDismiss: onDismiss, mtContent: content)
            )
        } else {
            mtSheet(isPresented: isPresented, onDismiss: onDismiss, content: content)
        }
        
    }
}


fileprivate struct MTSheetNoramlViewModifier<MTContent>: ViewModifier where MTContent: View {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    @ViewBuilder let mtContent: MTContent
    
    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if isPresented {
                        Rectangle()
                            .foregroundColor(isPresented ? Color.black.opacity(0.5) : Color.clear)
                            .ignoresSafeArea(edges: .all)
                            .onTapGesture {
                                isPresented = false
                            }
                        
                        VStack {
                            Spacer()
                            Capsule()
                                .frame(width: 80, height: 10)
                                .foregroundColor(Color.red)
                            
                            VStack {
                                mtContent
                            }
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.red
                                    .cornerRadius(30, corners: [.topLeft, .topRight])
                                    .ignoresSafeArea(edges: .bottom)
                            )
                        }
                        
                        .transition(.move(edge: .bottom))
                        .animation(.default)
                        
                        .onDisappear {
                            onDismiss?()
                        }
                    }
                }
                   
            )
            .onChange(of: isPresented) { showSheet in
                AppState.TabbarState.shared.hanlderSheetShow(showSheet)
            }
    }
    
}



//MARK: - Drag
fileprivate struct MTSheetDragViewModifier<MTContent>: ViewModifier where MTContent: View {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    @ViewBuilder let mtContent: MTContent
    
    @State private var startingOffsetY: CGFloat = ScreenHeight() - StatusBarH() - SafeBottomArea() - 200
    @State private var currentOffsetY: CGFloat = 0
    @State private var lastOffsetY: CGFloat = 0
    @GestureState private var gestureOffsetY: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(
                ZStack {
                    if isPresented {
                        Rectangle()
                            .foregroundColor(isPresented ? Color.black.opacity(0.05) : Color.clear)
                            .ignoresSafeArea(edges: .all)
                            .gesture(gesture)
                            .onTapGesture {
                                isPresented = false
                            }
                        
                        VStack {
                            Capsule()
                                .frame(width: 80, height: 10)
                                .foregroundColor(Color.red)
                            
                            ZStack {
                                Rectangle()
                                    .fill(Color.red)
                                    .cornerRadius(30, corners: [.topLeft, .topRight])
                                    .ignoresSafeArea(edges: .bottom)
                                
                                VStack {
                                    mtContent
                                }
                                .frame(maxHeight: .infinity, alignment: .top)
                            }
                        }
                        
                        .offset(y: startingOffsetY)
                        .offset(y: getOffsetY())
    
                        .gesture(gesture)
                        .transition(.move(edge: .bottom))
                        .animation(.default)
                        
                        .onDisappear {
                            resetOffset()
                            onDismiss?()
                        }
                        
                    }
                }
                   
            )
            .onChange(of: isPresented) { showSheet in
                AppState.TabbarState.shared.hanlderSheetShow(showSheet)
            }
    }
    
    
    func resetOffset() {
        currentOffsetY = 0
        lastOffsetY = 0
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.currentOffsetY = gestureOffsetY + lastOffsetY
        }
    }
    
    func getOffsetY() -> CGFloat {
        if -currentOffsetY > 0 {
            if -currentOffsetY <= startingOffsetY {
               return  currentOffsetY
            } else {
               return -startingOffsetY
            }
        } else {
           return 0
        }
    }
    
    var gesture: some Gesture {
        DragGesture()
            .updating($gestureOffsetY, body: { value, out, _ in
                out = value.translation.height
                onChange()
            })
            .onEnded({ value in
                let maxHeight = startingOffsetY
                withAnimation(.spring()) {
                    if -currentOffsetY > 100 && -currentOffsetY < maxHeight / 2 {
                        //Mid...
                        currentOffsetY = -(maxHeight / 3)
                    } else  if -currentOffsetY > maxHeight / 2 {
                        currentOffsetY = -maxHeight
                    } else {
                        currentOffsetY = 0
                    }
                    
                    lastOffsetY = currentOffsetY
                }
            })
    }
    
    
}































//MARK: - 废弃
//fileprivate struct MTFullSheetUseMtFullScreenCoverViewModifier: ViewModifier {
//    @Binding var isPresented: Bool
//
//    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.75
//    @State private var endingOffsetY: CGFloat = 0
//    //    @State var centerOffsetY: CGFloat = UIScreen.main.bounds.height * 0.5
//    @State private var currentDragOffsetY: CGFloat = 0
//
//    @State private var isOnAppear = false
//    func body(content: Content) -> some View {
//        content
////            .overlay(
////                Rectangle()
////                    .fill(isOnAppear ? Color.black.opacity(0.05) : .clear)
////                    .ignoresSafeArea(edges: .all)
////            )
//            .mtFullScreenCover(isPresented: $isPresented) {
//                Rectangle()
//                    .fill(isOnAppear ? Color.black.opacity(0.05) : .clear)
//                    .animation(.default.delay(0.15))
//                    .opacity(isPresented ? 1 : 0)
//                    .animation(nil)
//                    .ignoresSafeArea(edges: .all)
//                    .gesture(gesture)
//                    .onTapGesture {
//                        isPresented = false
//                    }
//
//
//                VStack {
//                    Spacer()
//
//                    VStack {
//                        VStack {
//                            Text("\(currentDragOffsetY)")
//                            Button {
//                                isPresented = false
//                            } label: {
//                                Text("关闭")
//                            }
//
//
//                            Spacer()
//                        }
//                        .frame(maxWidth: .infinity)
//                        .background(Color.red)
//                        .cornerRadius(30)
//
//                        .offset( y: startingOffsetY)
//                        .offset( y: currentDragOffsetY)
//                        //            .offset( y: centerOffsetY)
//                        .offset( y: endingOffsetY)
//                        .gesture(gesture)
//
//                    }
//                    .onAppear {
//                        print("home sheet onappear")
//                        isOnAppear = true
//                    }
//                    .onDisappear {
//                        print("home sheet onDisappear")
//                        isOnAppear = false
//                        resetOffset()
//                    }
//                }
//
//            }
//    }
//
//
//    func resetOffset() {
//        currentDragOffsetY = 0
//        endingOffsetY = 0
//    }
//
//    var gesture: some Gesture {
//        DragGesture()
//            .onChanged({ vale in
//                withAnimation(.spring()) {
//                    currentDragOffsetY = vale.translation.height
//                }
//            })
//            .onEnded({ value in
//                withAnimation(.spring()) {
//                    //负数上提 正数下拉
//                    if currentDragOffsetY < -150 {
//
//                        endingOffsetY = -startingOffsetY
//                        currentDragOffsetY = 0
//                    } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
//                        currentDragOffsetY = 0
//                        endingOffsetY = 0
//                    } else {
//                        currentDragOffsetY = 0
//                    }
//                }
//            })
//    }
//
//}



//
//struct MTSheetViewModifier<MTContent>: ViewModifier where MTContent : View {
//    @EnvironmentObject private var sheetManager: MTSheetManager
//
//    @Binding var isPresented: Bool
////    var currentModal: MTSheetModel? = nil
//    @ViewBuilder let mtContent: MTContent
//
//    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.75
//    @State private var endingOffsetY: CGFloat = 0
//    //    @State var centerOffsetY: CGFloat = UIScreen.main.bounds.height * 0.5
//    @State private var currentDragOffsetY: CGFloat = 0
//
//
//    func body(content: Content) -> some View {
//        content
//            .overlay(
//                VStack {
//                    if isPresented {
//                        VStack {
//                            VStack {
//                                Text("\(currentDragOffsetY)")
//                                Button {
//                                    isPresented = false
//                                } label: {
//                                    Text("关闭")
//                                }
//
//                                mtContent
//
//                                Spacer()
//                            }
//                            .frame(maxWidth: .infinity)
//                            .background(Color.red)
//                            .cornerRadius(30)
//
//                            .offset( y: startingOffsetY)
//                            .offset( y: currentDragOffsetY)
//                            //            .offset( y: centerOffsetY)
//                            .offset( y: endingOffsetY)
//                            .gesture(gesture)
//
//                        }
//                        .transition(.move(edge: .bottom))
//
////                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .fly))
//                        .animation(.default)
//
//                    }
//                }
//            )
//            .onChange(of: isPresented) { isShow in
//                withAnimation {
//                    AppState.TabbarState.shared.isShowTabbar = !isShow
//                }
//            }
//    }
//
//
//
//
//    var gesture: some Gesture {
//        DragGesture()
//            .onChanged({ vale in
//                withAnimation(.spring()) {
//                    currentDragOffsetY = vale.translation.height
//                }
//            })
//            .onEnded({ value in
//                withAnimation(.spring()) {
//                    //负数上提 正数下拉
//                    if currentDragOffsetY < -150 {
//
//                        endingOffsetY = -startingOffsetY
//                        currentDragOffsetY = 0
//                    } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
//                        currentDragOffsetY = 0
//                        endingOffsetY = 0
//                    } else {
//                        currentDragOffsetY = 0
//                    }
//                }
//            })
//    }
//
//}
