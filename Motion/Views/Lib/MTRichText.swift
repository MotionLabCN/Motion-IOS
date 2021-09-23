//
//  MTRichText.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/23.
//

import SwiftUI
import YYText
import MotionComponents

//MARK: - 富文本
struct MTRichText: View {
    private let preferredMaxLayoutWidth: CGFloat
    private let textHeigth: CGFloat
    private var text: NSAttributedString
    
    init(preferredMaxLayoutWidth: CGFloat, text: NSAttributedString) {
        self.text = text
        self.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        
        let textSize = CGSize(width: preferredMaxLayoutWidth, height: 100)
        let container = YYTextContainer(size: textSize)
        let layout = YYTextLayout(container: container, text: text)
        textHeigth = layout?.textBoundingSize.height ?? 0
    }
    
    var body: some View {
        MTRichTextRepresentable(preferredMaxLayoutWidth: preferredMaxLayoutWidth, attributedString: text)
            .frame(height: textHeigth)
    }
}

//MARK: - 桥接
fileprivate struct MTRichTextRepresentable: UIViewRepresentable {
    let preferredMaxLayoutWidth: CGFloat
    let attributedString: NSAttributedString
 
    func makeUIView(context: Context) -> YYLabel {
        let lb = YYLabel()
        lb.preferredMaxLayoutWidth = preferredMaxLayoutWidth
        lb.numberOfLines = 0
        lb.attributedText = attributedString
        return lb
    }
    
    func updateUIView(_ lb: YYLabel, context: Context) {

    }
}


//MARK: - 为MTRichText扩展的
public extension NSAttributedString {
    func onTap(rang: NSRange, tapAction: @escaping (NSAttributedString, NSAttributedString) -> Void) -> NSAttributedString {
        let mut = NSMutableAttributedString(attributedString: self)
        mut.yy_setTextHighlight(rang, color: nil, backgroundColor: nil) { _, text, rang, _ in
            tapAction(text, text.attributedSubstring(from: rang))
        }
        return mut
    }
    
    func onTap(subString: String, tapAction: @escaping (NSAttributedString, NSAttributedString) -> Void) -> NSAttributedString {
        return onTap(rang: range(of: subString), tapAction: tapAction)
    }
    
}











































struct MTRichText_Previews: PreviewProvider {
    static var previews: some View {
        MTRichText(preferredMaxLayoutWidth: ScreenWidth() - 76, text: "同意《中国移动认证服务条款》,以及Motion的用户协议，隐私条款和其他声明。"
                    .colored(with: .mt.accent_purple)
                    .font(with: .systemFont(ofSize: 20))
                    .applying(attributes: [.foregroundColor: UIColor.mt.accent_900], toRangesMatching: "Motion")
        )
    }
}
