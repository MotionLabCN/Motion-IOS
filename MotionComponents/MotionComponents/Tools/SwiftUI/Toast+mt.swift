//
//  MTToastViewModifier.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/14.
//

import SwiftUI

//MARK: - 类型
public struct MTToast {
    public enum DismissTime {
        case auto(duration: Double)
        case never
    }
    
    public  enum Postion {
        case bottom(offsetY: CGFloat)
        case top(offsetY: CGFloat)
        case center(offsetY: CGFloat)
    }
}

//MARK: - 辅助方法
extension MTToastViewModifier {
    private class DispatchWorkHolder {
        var work: DispatchWorkItem?
    }

    private final class ClassReference<T> {
        var value: T
        
        init(_ value: T) {
            self.value = value
        }
    }
}

//MARK: - ToastViewModifier
struct MTToastViewModifier<MTContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    private let mtContent:  MTContent

    private var dispatchWorkHolder = DispatchWorkHolder()
    private var isPresentedRef: ClassReference<Binding<Bool>>?

    private var dismissTime: MTToast.DismissTime
    private var postion: MTToast.Postion
    
    @GestureState private var dragOffsetY: CGFloat = 0

    init(isPresented: Binding<Bool>, dismissTime: MTToast.DismissTime, postion: MTToast.Postion, @ViewBuilder content: () -> MTContent) {
        self._isPresented = isPresented
        self.dismissTime = dismissTime
        self.postion = postion
        self.mtContent = content()
        self.isPresentedRef = ClassReference(self.$isPresented)
        checkDismiss()
    }
    
    
    func checkDismiss() {
        switch dismissTime {
        case  let .auto(duration):
            dispatchWorkHolder.work?.cancel()
            
            dispatchWorkHolder.work = DispatchWorkItem(block: {
                isPresented = false
            })
            if isPresented, let work = dispatchWorkHolder.work {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: work)
            }
        default:
            break
        }
    }
    
    
    func body(content: Content) -> some View {
        content.overlay(
            Group {
                if isPresented {
                    switch postion {
                    case let .bottom(offsetY):
                        VStack {
                            Spacer()
                            mtContent
                                .simultaneousGesture(dragGesture)
                                .padding(.bottom, offsetY)
                                .offset(y: dragOffsetY)
                                
                        }
                        .transition(.move(edge: .bottom))
                        .animation(.default)
                    case let .top(offsetY):
                        VStack {
                            mtContent
                                .simultaneousGesture(dragGesture)
                                .padding(.top, offsetY)
                                .offset(y: dragOffsetY)
                            Spacer()
                                
                        }
                        .transition(.move(edge: .top))
                        .animation(.default)
                    case let .center(offsetY):
                        mtContent
                            .simultaneousGesture(dragGesture)
                            .padding(.top, offsetY)
                            .offset(y: dragOffsetY)
                            .transition(.opacity)
                            .animation(.default)
                    }
                }
            }
        )
        
    }
    
    var dragGesture: some Gesture {
      DragGesture()
            .updating($dragOffsetY, body: { currentstate, gestureState, transaction in
                gestureState = currentstate.translation.height
            })
            .onChanged({ _ in
                dispatchWorkHolder.work?.cancel()
            })
            .onEnded({ value in
                checkDismiss()
            })
    }
    
}



public struct MTToastConfig {
    public var isPresented: Binding<Bool>
    public var text: String
    public var style: MTPushNofi.PushNofiType
    public var dismissTime:  MTToast.DismissTime
    public var postion: MTToast.Postion
    public var didClickClose: Block_T?
    
    public init(isPresented: Binding<Bool>, text: String, style: MTPushNofi.PushNofiType = .defult, dismissTime:  MTToast.DismissTime = .auto(duration: 3), postion: MTToast.Postion = .bottom(offsetY: 0), didClickClose: Block_T? = nil) {
        self.isPresented = isPresented
        self.text = text
        self.style = style
        self.dismissTime = dismissTime
        self.postion = postion
        self.didClickClose = didClickClose
    }
}

