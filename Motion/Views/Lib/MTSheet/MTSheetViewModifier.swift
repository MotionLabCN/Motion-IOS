//
//  MTSheetViewModifier.swift
//  MotionDesgin
//
//  Created by 梁泽 on 2021/9/23.
//

import SwiftUI



struct MTSheetViewModifier<MTContent>: ViewModifier where MTContent : View {
    @EnvironmentObject private var sheetManager: MTSheetManager

    @Binding var isPresented: Bool
//    var currentModal: MTSheetModel? = nil
    @ViewBuilder let mtContent: MTContent

    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.75
    @State private var endingOffsetY: CGFloat = 0
    //    @State var centerOffsetY: CGFloat = UIScreen.main.bounds.height * 0.5
    @State private var currentDragOffsetY: CGFloat = 0
    

    func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    if isPresented {
                        VStack {
                            VStack {
                                Text("\(currentDragOffsetY)")
                                mtContent                            

                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(30)
                            
                            .offset( y: startingOffsetY)
                            .offset( y: currentDragOffsetY)
                            //            .offset( y: centerOffsetY)
                            .offset( y: endingOffsetY)
                            .gesture(gesture)
                            
                        }
                        .transition(.move(edge: .bottom))
                        .animation(.default)

                    }
                }
            )
    }
    
        
    
    
    var gesture: some Gesture {
        DragGesture()
            .onChanged({ vale in
                withAnimation(.spring()) {
                    currentDragOffsetY = vale.translation.height
                }
            })
            .onEnded({ value in
                withAnimation(.spring()) {
                    //负数上提 正数下拉
                    if currentDragOffsetY < -150 {
                        
                        endingOffsetY = -startingOffsetY
                        currentDragOffsetY = 0
                    } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                        currentDragOffsetY = 0
                        endingOffsetY = 0
                    } else {
                        currentDragOffsetY = 0
                    }
                }
            })
    }
    
}
