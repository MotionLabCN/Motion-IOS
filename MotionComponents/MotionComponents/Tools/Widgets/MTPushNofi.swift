//
//  NofiHud.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/10.
//

import SwiftUI


public extension MTPushNofi {
    enum PushNofiType: String, CaseIterable, Identifiable {
        public var id: String { rawValue }
        case defult, danger, success, warning
        
        public var color: Color {
            switch self {
            case .defult: return .mt.gray_800
            case .danger: return .mt.status_danger
            case .success: return .mt.status_sucess
            case .warning: return .mt.status_warnning
            }
        }
        
    }
}

extension MTPushNofi {
    public struct Config {
        public var text: String 
        public var isShow: Bool
        
        public init(text: String, isShow: Bool) {
            self.text = text
            self.isShow = isShow
        }
    }
}

//@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct MTPushNofi: View {
    let text: String
    let isCancellable: Bool
    let style: MTPushNofi.PushNofiType
    
    let didClickClose: Block_T?
    
    public init(text: String, style: MTPushNofi.PushNofiType = .defult, isCancellable: Bool = false, didClickClose: Block_T? = nil) {
        self.text = text
        self.style = style
        self.isCancellable = isCancellable
        self.didClickClose = didClickClose
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Text(text)
                .font(.mt.body1, textColor: .white)
                .frame(maxWidth: .infinity, alignment: .leading)
            if isCancellable {
                Spacer()
                
                Button(action: {
                    didClickClose?()
                }, label: {
                    Image.mt.load(.Close)
                        .foregroundColor(.white)
                })
                .mtAnimation(isOverlay: true)
            }
        }
        .padding(16)
        .background(
            style.color
        )
        .frame(width: ScreenWidth() - 32)
        .cornerRadius(12)
        .shadow(type: .shadowMid)
    }
}



//#if  DEBUG
//@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
//struct MTPushNofi_Preview: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MTPushNofi(text: "文本toast", style: .danger)
//        }
//    }
//}
//#endif
