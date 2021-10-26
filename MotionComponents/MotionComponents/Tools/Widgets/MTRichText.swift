
//
//  MTRichText.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/25.
//

import SwiftUI
@_exported import ActiveLabel

/// 桥接高度
fileprivate class MTActiveLabelViewModel: ObservableObject {
    @Published var textHeight: CGFloat = 0
}



public struct MTRichText: View {
    let text: String
    private var config = MTActiveLabelConfig()
    @StateObject private var vm = MTActiveLabelViewModel()
    
    public init(_ text: String) {
        self.text = text
    }
    public var body: some View {
        GeometryReader { proxy in
            MTActiveLabelRepresentable(preferredMaxLayoutWidth: proxy.width, text: text, config: config, vm: vm)
        }
        .frame(height: vm.textHeight)
    }
}


//public struct MTRichTextPreferenceKey: PreferenceKey {
//    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//        let r = nextValue()
//        print("")
//        value = r
//
//    }
//
//    public static var defaultValue: CGFloat = 0
//}
//public struct MTRichText_old: View {
//    let preferredMaxLayoutWidth: CGFloat
//    let text: String
//
//    private var config = MTActiveLabelConfig()
//    @StateObject private var vm = MTActiveLabelViewModel()
//
//    public init(preferredMaxLayoutWidth: CGFloat, text: String) {
//        self.preferredMaxLayoutWidth = preferredMaxLayoutWidth
//        self.text = text
//    }
//
//    public var body: some View {
//        MTActiveLabelRepresentable(preferredMaxLayoutWidth: preferredMaxLayoutWidth, text: text, config: config, vm: vm)
//            .frame(height: vm.textHeight)
//            .preference(key: MTRichTextPreferenceKey.self, value: vm.textHeight)
//    }
//}


//MARK: - 扩展
public extension MTRichText {
    func textFont(_ font: UIFont) -> Self {
        config.textFont = font
        return self
    }

    func textColor(_ color: SwiftUI.Color) -> Self {
        config.textColor = color
        return self
    }
    
    func textColor(_ color: SwiftUI.Color, font: UIFont) -> Self {
        config.textColor = color
        config.textFont = font
        return self
    }

    func hashtagColor(_ color: SwiftUI.Color) -> Self {
        config.hashtagColor = color
        return self
    }

    func mentionColor(_ color: SwiftUI.Color) -> Self {
        config.mentionColor = color
        return self
    }

    func URLColor(_ color: SwiftUI.Color) -> Self {
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
    
    func customTypeColor(_ customColor: [ActiveType: SwiftUI.Color]) -> Self {
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

    func onCustomTaps(actions: [ActiveType : ((String) -> ())]) -> Self {
        config.customTapHandlers = actions
        return self
    }
    
    func onCustomTapActions1(actions: Int) -> MTRichText {
//        config.customTapHandlers = typeActions
        return self
    }

    func updateForState(_ isUpdate: Bool) -> Self {
        config.needUpdateForState = isUpdate
        return self
    }

}


fileprivate class MTActiveLabelConfig: ObservableObject {
    var textFont: UIFont = .mt.body2
    var numberOfLines: Int = 0
    var lineSpacing: CGFloat = 10
    var textColor: SwiftUI.Color = .mt.gray_900
    var hashtagColor: SwiftUI.Color = .blue
    var mentionColor: SwiftUI.Color = .mt.accent_700
    var URLColor: SwiftUI.Color = .blue
    var urlMaximumLength: Int = 30
    var backgroundColor: UIColor = .clear
    var enabledTypes: [ActiveType] = [.mention, .hashtag, .url]
    var customTypes: [ActiveType] = []
    var customColor: [ActiveType: SwiftUI.Color] = [:]
    var configureLinkAttribute: ConfigureLinkAttribute?
    
    var mentionTapHandler: ((String) -> ())?
    var hashtagTapHandler: ((String) -> ())?
    var urlTapHandler: ((URL) -> ())?
    var customTapHandlers: [ActiveType : ((String) -> ())] = [:]
    
    var needUpdateForState = false
}


//MARK: - 桥接
fileprivate struct MTActiveLabelRepresentable: UIViewRepresentable {
    let preferredMaxLayoutWidth: CGFloat
    let text: String
    let config: MTActiveLabelConfig
    let vm: MTActiveLabelViewModel
    private let label = ActiveLabel()

    func makeUIView(context: Context) -> ActiveLabel {
        if !config.needUpdateForState {
            p_update()
        }
        return label
    }
    
    func updateUIView(_ label: ActiveLabel, context: Context) {
        if config.needUpdateForState {
            p_update()
        }
    }
    
    private func p_update() {
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
        vm.textHeight = size.height
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
    @State private var text = "This is a post with #multiple #hashtags and a @userhandle. Links are also supported like" +
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
            MTRichText(text)
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





















//MARK: - YYLable版
//
//  MTRichText.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/23.
//

//import SwiftUI
//import YYText
//import MotionComponents
//
////MARK: - 富文本
//struct MTRichText: View {
//    private let preferredMaxLayoutWidth: CGFloat
//    private let textHeigth: CGFloat
//    private var text: NSAttributedString
//
//    init(preferredMaxLayoutWidth: CGFloat, text: NSAttributedString) {
//        self.text = text
//        self.preferredMaxLayoutWidth = preferredMaxLayoutWidth
//
//        let textSize = CGSize(width: preferredMaxLayoutWidth, height: 100)
//        let container = YYTextContainer(size: textSize)
//        let layout = YYTextLayout(container: container, text: text)
//        textHeigth = layout?.textBoundingSize.height ?? 0
//    }
//
//    var body: some View {
//        MTRichTextRepresentable(preferredMaxLayoutWidth: preferredMaxLayoutWidth, attributedString: text)
//            .frame(height: textHeigth)
//    }
//}
//
////MARK: - 桥接
//fileprivate struct MTRichTextRepresentable: UIViewRepresentable {
//    let preferredMaxLayoutWidth: CGFloat
//    let attributedString: NSAttributedString
//
//    func makeUIView(context: Context) -> YYLabel {
//        let lb = YYLabel()
//        lb.preferredMaxLayoutWidth = preferredMaxLayoutWidth
//        lb.numberOfLines = 0
//        lb.attributedText = attributedString
//        return lb
//    }
//
//    func updateUIView(_ lb: YYLabel, context: Context) {
//
//    }
//}
//
//
////MARK: - 为MTRichText扩展的
//public extension NSAttributedString {
//    func onTap(rang: NSRange, tapAction: @escaping (NSAttributedString, NSAttributedString) -> Void) -> NSAttributedString {
//        let mut = NSMutableAttributedString(attributedString: self)
//        mut.yy_setTextHighlight(rang, color: nil, backgroundColor: nil) { _, text, rang, _ in
//            tapAction(text, text.attributedSubstring(from: rang))
//        }
//        return mut
//    }
//
//    func onTap(subString: String, tapAction: @escaping (NSAttributedString, NSAttributedString) -> Void) -> NSAttributedString {
//        return onTap(rang: range(of: subString), tapAction: tapAction)
//    }
//
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//struct MTRichText_Previews: PreviewProvider {
//    static var previews: some View {
//        MTRichText(preferredMaxLayoutWidth: ScreenWidth() - 76, text: "同意《中国移动认证服务条款》,以及Motion的用户协议，隐私条款和其他声明。"
//                    .colored(with: .mt.accent_purple)
//                    .font(with: .systemFont(ofSize: 20))
//                    .applying(attributes: [.foregroundColor: UIColor.mt.accent_900], toRangesMatching: "Motion")
//        )
//    }
//}
