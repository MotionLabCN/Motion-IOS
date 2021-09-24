//
//  MTActiveLabel.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/24.
//

import SwiftUI
@_exported import ActiveLabel


struct MTActiveLabel: View {
    let preferredMaxLayoutWidth: CGFloat
    let text: String
    var urlMaximumLength: Int? = 10
    var lineSpacing: CGFloat = 2
    
    var textColor: Color = .mt.gray_700
    var hashtagColor: Color = .mt.accent_900
    var mentionColor: Color = .mt.accent_purple
    var URLColor: Color = .red
    
    var customTypes: [ActiveType] = []
    var configureLinkAttribute: ConfigureLinkAttribute? = nil
    var tapHandler: ((ActiveType, String) -> ())?
    
    @State private var textHeight: CGFloat = 0
    
    var body: some View {
        MTActiveLabelRepresentable(preferredMaxLayoutWidth: preferredMaxLayoutWidth, text: text, customTypes: customTypes, urlMaximumLength: urlMaximumLength, lineSpacing: lineSpacing, textColor: textColor, hashtagColor: hashtagColor, mentionColor: mentionColor, URLColor: URLColor, configureLinkAttribute: configureLinkAttribute, textHeight: $textHeight, tapHandler: tapHandler)
            .frame(height: textHeight)
    }
}


//typealias ConfigureLinkAttribute = (ActiveType, [NSAttributedString.Key : Any], Bool) -> ([NSAttributedString.Key : Any])
struct MTActiveLabel_Previews: PreviewProvider {
    static var previews: some View {
        let customType = ActiveType.custom(pattern: "《哈哈》")
        let config: ConfigureLinkAttribute = { type, attributes, _ in
            var atts = attributes
            switch type {
            case customType:
                atts[.font] = UIFont.systemFont(ofSize: 30)
            default:
                break
            }
            return atts
        }
        MTActiveLabel(preferredMaxLayoutWidth: 400, text: "中国《哈哈》有嘻哈", customTypes: [customType], configureLinkAttribute: config)
            .previewLayout(.fixed(width: 400, height: 100))
    }
}


//MARK: - 桥接
fileprivate struct MTActiveLabelRepresentable: UIViewRepresentable {
    let preferredMaxLayoutWidth: CGFloat
    let text: String
    let customTypes: [ActiveType]
    let urlMaximumLength: Int?
    let lineSpacing: CGFloat
    
    let textColor: Color
    let hashtagColor: Color
    let mentionColor: Color
    let URLColor: Color
    
    var configureLinkAttribute: ConfigureLinkAttribute?
    @Binding var textHeight: CGFloat

    var tapHandler: ((ActiveType, String) -> ())?

 
    func makeUIView(context: Context) -> ActiveLabel {
        let label = ActiveLabel()
        label.font = UIFont.systemFont(ofSize: 50)
        for customType in customTypes {
            label.enabledTypes.append(customType)
        }
        
        label.urlMaximumLength = urlMaximumLength
        label.preferredMaxLayoutWidth = preferredMaxLayoutWidth

        label.customize { label in
            label.text = text
            label.numberOfLines = 0
            label.lineSpacing = lineSpacing
            
            label.textColor = UIColor(textColor)
            label.hashtagColor = UIColor(hashtagColor)
            label.mentionColor = UIColor(mentionColor)
            label.URLColor = UIColor(URLColor)
//            label.URLSelectedColor = UIColor(red: 82.0/255, green: 190.0/255, blue: 41.0/255, alpha: 1)
            
            label.configureLinkAttribute = configureLinkAttribute

            label.handleMentionTap {
                tapHandler?(.mention, $0)
            }
            label.handleHashtagTap {
                tapHandler?(.hashtag, $0)
            }
            label.handleURLTap({
                tapHandler?(.url, $0.absoluteString)
            })

            
           

            for customType in customTypes {
                label.handleCustomTap(for: customType) { text in
                    tapHandler?(customType, text)
                }
            }
        }
        
        let size = label.intrinsicContentSize
        DispatchQueue.main.async {
            textHeight = size.height
        }
        return label
    }
    
    func updateUIView(_ label: ActiveLabel, context: Context) {
        
    }
}

