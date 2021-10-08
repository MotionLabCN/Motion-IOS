//
//  MTPageSegmentView.swift
//  MotionComponents
//
//  Created by 梁泽 on 2021/10/8.
//

import SwiftUI


public protocol MTPageSegmentProtocol {
    var showText: String { get }
}

extension String: MTPageSegmentProtocol {
    public var showText: String { self }
}

public struct MTPageSegmentView: View {
    var titles: [MTPageSegmentProtocol]
    @Binding var offset: CGFloat
    ///可以监听offset算pageindex
    public var pageIndex: Int {
        Int(floor(offset + 0.5) / ScreenWidth())
    }
    
    public init(titles: [MTPageSegmentProtocol], offset: Binding<CGFloat>) {
        self.titles = titles
        self._offset = offset
    }
    
    public var body: some View {
        GeometryReader { proxy -> AnyView in
            let totalWidth = proxy.frame(in: .global).width
            let equalWidth = totalWidth / titles.count.cgFloat
            
//            DispatchQueue.main.async {
//                width = equalWidth
//            }
            
            let progress = offset / ScreenWidth()
            let offsetX = progress * equalWidth
            
            return AnyView(
                ZStack(alignment: .bottomLeading) {
                    HStack(spacing: 0 ) {
                        ForEach(titles.indices, id: \.self) { index in
                            Text(titles[index].showText)
                                .font(.mt.body1.mtBlod(),textColor: pageIndex  == index ? .black : .mt.gray_700)
                                .frame(maxHeight: .infinity)
                                .frame(width: equalWidth, alignment: .center)
                                .onTapGesture {
                                    withAnimation {
                                        offset = ScreenWidth() * index.cgFloat
                                    }
                                }
                        }
                    }

                    Divider.mt.defult()
                    
                    Capsule()
                        .foregroundColor(Color.mt.accent_800)
                        .frame(width: equalWidth - 24, height: 3)
                        .offset(x: offsetX + 12)
                }
                    .onChange(of: offset, perform: { newValue in
                        print(pageIndex)
                    })
            )
           
        }
        .frame(height: 44)
    }
    
//    func getOffset() -> CGFloat {
//        let progress = offset / ScreenWidth()
//        return progress * width
//    }
}


//struct MTPageSegmentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MTPageSegmentView()
//    }
//}
