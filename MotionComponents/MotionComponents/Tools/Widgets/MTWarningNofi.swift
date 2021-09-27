//
//  MTWarningNofi.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/27.
//

import SwiftUI


public struct MTWarningNofi: View {
    let image: Image
    let title: String?
    let content: String?
    let buttonTitle: String?
    let action: Block_T?
    
    public init(icon: Image, title: String?, content: String?, buttonTitle: String?, action: Block_T?) {
        self.image = icon
        self.title = title
        self.content = content
        self.buttonTitle = buttonTitle
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 24.0) {
            mainView

            if buttonTitle != nil {
                btn
            }
        }
        .frame(maxWidth: ScreenWidth() - 32)
    }
    
  
    
    private var mainView: some View {
        VStack(spacing: 11.0) {
            image
                .foregroundColor(.mt.status_danger)
            
            Group {
                if let title = title {
                    Text(title)
                        .font(.mt.body1.mtBlod(), textColor: .mt.gray_900)
                }
                if let content = content {
                    Text(content)
                        .font(.mt.body2, textColor: .mt.gray_900)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(Color.white.cornerRadius(12))
    }
    
    private var btn: some View {
        VStack {
            Button(buttonTitle!) {
                action?()
            }
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(Color.white.cornerRadius(12))

        }
    }
    
}

//struct MTWarningNofi_Previews: PreviewProvider {
//    static var previews: some View {
//        MTWarningNofi()
//    }
//}
