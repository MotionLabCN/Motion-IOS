//
//  TextField+mt.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/13.
//

import SwiftUI


public extension TextField {
    func mtTextFieldStyle(_ text: Binding<String>, config: MTTextFieldStyle.Config) -> some View {
        self.textFieldStyle(MTTextFieldStyle(text: text, config: config))
    }
}


public struct MTTextFieldStyle: TextFieldStyle {
    @Binding var text: String
    public var config = Config()

    /*
    desc:
    subText:
    subTextColor:
    lineColor:
    isShowLoading:
     */
    public struct Config {
        public var desc: String?
        public var subText: String?
        public var subTextColor: Color
        public var lineColor: Color
        public var isShowLoading: Bool
        
        public init(desc: String? = nil, subText: String? = nil, subTextColor: Color = .mt.gray_400, lineColor: Color = .mt.gray_200, isShowLoading: Bool = false) {
            self.desc = desc
            self.subText = subText
            self.subTextColor = subTextColor
            self.lineColor = lineColor
            self.isShowLoading = isShowLoading
        }
    }
    
    public init(text: Binding<String>, config: MTTextFieldStyle.Config) {
        self._text = text
        self.config = config
    }
  
    public func _body(configuration: TextField<Self._Label>) -> some View {
        HStack {
            HStack {
                configuration
                    .font(.mt.body2)
                    .foregroundColor(.black)
                    .accentColor(.mt.accent_800)
                    .frame(minHeight: 24)
                
                if config.isShowLoading {
                    ProgressView()
                }
            }
            
            if config.isShowLoading == false {
                if !text.isEmpty {
                    Button {
                        self.text = ""
                    } label: {
                        Image.mt.load(.Close_circle)
                            .transition(.opacity)
                            .foregroundColor(Color.black)
                    }
                } else if let subText = config.subText {
                    Text(subText)
                        .font(.mt.caption1, textColor: config.subTextColor)
                        .frame(alignment: .trailing)
                }
            }
        }
        .mtAnimation()
        .padding(.bottom, 8)
        .modifier(MTUnderlineModifier(lineColor: config.lineColor))
        .modifier(MTAttachTextModifier(text: config.desc, attached: .textField))
    }
}

