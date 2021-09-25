//
//  MTActiveLabel.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/24.
//

import SwiftUI
import MotionComponents
@_exported import ActiveLabel

struct MTActiveLabel: View {
    let preferredMaxLayoutWidth: CGFloat
    let text: String
    // 私有属性
    @State private var textHeight: CGFloat = 0
    private var config = MTActiveLabelConfig()
    
    init(preferredMaxLayoutWidth: CGFloat, text: String) {
        self.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        self.text = text
    }
    
    var body: some View {
        MTActiveLabelRepresentable(preferredMaxLayoutWidth: preferredMaxLayoutWidth, text: text, config: config, textHeight: $textHeight)
            .frame(height: textHeight)
    }
}


//MARK: - 扩展
extension MTActiveLabel {
    func textFont(_ font: UIFont) -> Self {
        config.textFont = font
        return self
    }

    func textColor(_ color: Color) -> Self {
        config.textColor = color
        return self
    }

    func hashtagColor(_ color: Color) -> Self {
        config.hashtagColor = color
        return self
    }

    func mentionColor(_ color: Color) -> Self {
        config.mentionColor = color
        return self
    }

    func URLColor(_ color: Color) -> Self {
        config.URLColor = color
        return self
    }

    func urlMaximumLength(_ length: Int) -> Self {
        config.urlMaximumLength = length
        return self
    }

    func lineSpacing(_ lineSpacing: CGFloat) -> Self {
        config.lineSpacing = lineSpacing
        return self
    }
    
    func customTypes(_ types: [ActiveType]) -> Self {
        config.customTypes = types
        return self
    }
    
    func customTypeColor(_ customColor: [ActiveType: Color]) -> Self {
        config.customColor = customColor
        return self
    }
    
    func configureLinkAttribute(_ attri: @escaping ConfigureLinkAttribute) -> Self {
        config.configureLinkAttribute = attri
        return self
    }
    
    
    //MARK: - 事件
    func onMentionTap(_ handler: @escaping ((String) -> Void)) -> Self {
        config.mentionTapHandler = handler
        return self
    }

    func onHashtagTap(_ handler: @escaping ((String) -> Void)) -> Self {
        config.hashtagTapHandler = handler
        return self
    }

    func onURLTap(_ handler: @escaping ((URL) -> Void)) -> Self {
        config.urlTapHandler = handler
        return self
    }

    func onCustomTap(for type: ActiveType, handler: @escaping (String) -> ()) -> Self {
        config.customTapHandlers = [type: handler]
        return self
    }



}


fileprivate class MTActiveLabelConfig {
    var textFont: UIFont = .mt.body1
    var numberOfLines: Int = 0
    var lineSpacing: CGFloat = 20
    var textColor: Color = .gray
    var hashtagColor: Color = .blue
    var mentionColor: Color = .mt.accent_900
    var URLColor: Color = .blue
    var urlMaximumLength: Int = 30
    var backgroundColor = UIColor.yellow
    var enabledTypes: [ActiveType] = [.mention, .hashtag, .url]
    var customTypes: [ActiveType] = []
    var customColor: [ActiveType: Color] = [:]
    var configureLinkAttribute: ConfigureLinkAttribute?
    
    var mentionTapHandler: ((String) -> ())?
    var hashtagTapHandler: ((String) -> ())?
    var urlTapHandler: ((URL) -> ())?
    var customTapHandlers: [ActiveType : ((String) -> ())] = [:]
}


//MARK: - 桥接
fileprivate struct MTActiveLabelRepresentable: UIViewRepresentable {
    let preferredMaxLayoutWidth: CGFloat
    let text: String
    let config: MTActiveLabelConfig
    @Binding var textHeight: CGFloat
    private let label = ActiveLabel()

    func makeUIView(context: Context) -> ActiveLabel {
        return label
    }
    
    func updateUIView(_ label: ActiveLabel, context: Context) {
        label.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        label.enabledTypes = config.enabledTypes
        for customType in config.customTypes {
            label.enabledTypes.append(customType)
        }
        
        label.customize {  label in
            label.text = text
            label.font = config.textFont
            label.numberOfLines = config.numberOfLines
            label.lineSpacing = config.lineSpacing
            
            label.textColor = config.textColor.uicolor
            label.hashtagColor = config.hashtagColor.uicolor
            label.mentionColor = config.mentionColor.uicolor
            label.URLColor = config.URLColor.uicolor
            
            label.urlMaximumLength = config.urlMaximumLength
            label.backgroundColor = config.backgroundColor
            
            label.customColor = Dictionary(uniqueKeysWithValues: config.customColor.map({ ($0.key, $0.value.uicolor)} ))
            label.configureLinkAttribute = config.configureLinkAttribute

            if let handler = config.mentionTapHandler {
                label.handleMentionTap(handler)
            }
            if let handler = config.hashtagTapHandler {
                label.handleHashtagTap(handler)
            }
            if let handler = config.urlTapHandler {
                label.handleURLTap(handler)
            }
            for (key, value) in config.customTapHandlers {
                label.handleCustomTap(for: key, handler: value)
            }
        }
        
        let size = label.intrinsicContentSize
        DispatchQueue.main.async {
            textHeight = size.height
        }
    }
    
}


//extension MTActiveLabelRepresentable {
//    func textFont(_ font: UIFont) -> Self {
//        config.textFont = font
//        return self
//    }
//
//    func textColor(_ color: Color) -> Self {
//        config.textColor = color
//        return self
//    }
//
//    func hashtagColor(_ color: Color) -> Self {
//        config.hashtagColor = color
//        return self
//    }
//
//    func mentionColor(_ color: Color) -> Self {
//        config.mentionColor = color
//        return self
//    }
//
//    func URLColor(_ color: Color) -> Self {
//        config.URLColor = color
//        return self
//    }
//
//    func urlMaximumLength(_ length: Int) -> Self {
//        config.urlMaximumLength = length
//        return self
//    }
//
//    func lineSpacing(_ lineSpacing: CGFloat) -> Self {
//        config.lineSpacing = lineSpacing
//        return self
//    }
//
//    func customTypes(_ types: [ActiveType]) -> Self {
//        config.customTypes = types
//        return self
//    }
//
//    func customTypeColor(_ customColor: [ActiveType: Color]) -> Self {
//        config.customColor = customColor
//        return self
//    }
//
//    func configureLinkAttribute(_ attri: @escaping ConfigureLinkAttribute) -> Self {
//        config.configureLinkAttribute = attri
//        return self
//    }
//
//
//    //MARK: - 事件
//    func onMentionTap(_ handler: @escaping ((String) -> Void)) -> Self {
//        config.mentionTapHandler = handler
//        return self
//    }
//
//    func onHashtagTap(_ handler: @escaping ((String) -> Void)) -> Self {
//        config.hashtagTapHandler = handler
//        return self
//    }
//
//    func onURLTap(_ handler: @escaping ((URL) -> Void)) -> Self {
//        config.urlTapHandler = handler
//        return self
//    }
//
//    func onCustomTap(for type: ActiveType, handler: @escaping (String) -> ()) -> Self {
//        config.customTapHandlers = [type: handler]
//        return self
//    }
//
//
//
//}


//MARK: - 用法
struct MTActiveTestView: View {
    let customType1 = ActiveType.custom(pattern: "are")
    @State var text = "This is a post with #multiple #hashtags and a @userhandle. Links are also supported like" +
    " this one: http://optonaut.co. Now it also supports custom patterns -> are\n\n" +
        "Let's trim a long link: \nhttps://twitter.com/twicket_app/status/649678392372121601"
    
    var body: some View {
        return VStack {
            Button("change text") {
                if text == "中国有嘻哈" {
                    text = "This is a post with #multiple #hashtags and a @userhandle. Links are also supported like" +
                    " this one: http://optonaut.co. Now it also supports custom patterns -> are\n\n" +
                        "Let's trim a long link: \nhttps://twitter.com/twicket_app/status/649678392372121601"
                } else {
                    text = "中国有嘻哈"
                }
                
            }
            MTActiveLabel(preferredMaxLayoutWidth: 320, text: text)
                .textFont(.systemFont(ofSize: 25))
                .urlMaximumLength(12)
                .lineSpacing(1)
                .customTypeColor([customType1 : .red])
                .customTypes([customType1])
                .configureLinkAttribute({ t, attri, _ in
                    var att = attri
                    switch t {
                    case customType1:
                        att[.font] = UIFont.systemFont(ofSize: 50, weight: .black)
                    default:
                        att[.font] = UIFont.systemFont(ofSize: 25)
                    }
                    return att
                })
                .onMentionTap({ mention in
                    print("点mention \(mention)")
                })
                .onCustomTap(for: customType1, handler: { test in
                    print("click custom")
                })
            .frame(width: 320)
        }
        
    }
}

struct MTActiveLabel_Previews: PreviewProvider {
    static var previews: some View {
        MTActiveTestView()
    }
}
