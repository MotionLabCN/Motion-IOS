//
//  NextView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/14.
//

import SwiftUI
import MotionComponents

struct NextView: View {
    @Environment(\.presentationMode) var  presentationMode
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
        .sheet(isPresented: $isShowToast) {
            
        } content: {
            Text("123")
        }
    }
}


















struct NextView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        MTActiveLabelTestView()
    }
}

struct MTActiveLabelTestView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("123")
                
                let customType = ActiveType.custom(pattern: "\\sare\\b") //Looks for "are"
                let customType2 = ActiveType.custom(pattern: "\\sit\\b") //Looks for "it"
                let customType3 = ActiveType.custom(pattern: "\\ssupports\\b") //Looks for "supports"
                
                let configure: ConfigureLinkAttribute = { (type, attributes, isSelected)  in
                    var atts = attributes
                    switch type {
                    case .custom:
//                    case customType3:
                        atts[NSAttributedString.Key.font] = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.boldSystemFont(ofSize: 14)
                        atts[NSAttributedString.Key.foregroundColor] = UIColor.orange
                    default: break
                    }
                    
                    return atts
                }
                let text = "This is a post with #multiple #hashtags and a @userhandle. Links are also supported like" +
                " this one: http://optonaut.co. Now it also supports custom patterns -> are\n\n" +
                "Let's trim a long link: \nhttps://twitter.com/twicket_app/status/649678392372121601"
                MTActiveLabel(preferredMaxLayoutWidth: ScreenWidth() - 16, text: text, urlMaximumLength: 30, lineSpacing: 10, textColor: .black) { type, text in
                    print("hanler \(type)  \(text)")
                }
                MTActiveLabel(preferredMaxLayoutWidth: ScreenWidth() - 16, text: text , customTypes: [customType, customType2, customType3],
                              configureLinkAttribute: configure
                )
                Text("456")
            }
            .padding()
        }
    }
}




