//
//  MTDescriptionView.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/9/10.
//

import SwiftUI


public struct MTDescriptionView: View {
    let title: String
    let subTitle: String?
    
    public init(title: String, subTitle: String? = nil) {
        self.title = title
        self.subTitle = subTitle
    }
    
    public var body: some View {
        VStack(spacing: 4.0) {
            Text(title)
                .font(.mt.title2.mtBlod(), textColor: .black)
                .frame(width: 244, alignment: .center)

            if let subTitle = subTitle {
                Text(subTitle)
                    .font(.mt.body3, textColor: .mt.gray_800)
                    .frame(width: 218)
            }
        }
        .multilineTextAlignment(.center)
    }
}
