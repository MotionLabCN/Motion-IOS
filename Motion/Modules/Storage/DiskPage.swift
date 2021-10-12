//
//  DiskPage.swift
//  Motion
//
//  Created by Liseami on 2021/10/12.
//

import SwiftUI
import MotionComponents

struct Storage: View {
    
    @State var animationInt : Int = 0
    
    var body: some View {

                ScrollView(.vertical, showsIndicators: false) {
                    
                    Spacer()   .frame(height: ScreenWidth() * 0.3)
                    LazyVStack{
                        Today()
                            .offset(y: animationInt >= 1 ? 0 : -ScreenHeight() * 1.3)
                        ActiveUser()
                            .offset(y: animationInt >= 2 ? 0 : -ScreenHeight() * 1.3)
                        Message()
                            .offset(y: animationInt >= 3 ? 0 : -ScreenHeight() * 1.3)
                        
                  
                        Spacer()
                            .frame(height: ScreenHeight() * 0.1)
                        
                        Button("成为存储提供者"){
                        }.mtButtonStyle(.mainDefult(isEnable: true))
                            .padding(.horizontal,56)
                            .offset(y: animationInt >= 4 ? 0 : -ScreenHeight() * 1.3)
                        Button("存储文件"){
                        }.mtButtonStyle(.mainGradient)
                            .padding(.horizontal,56)
                            .offset(y: animationInt >= 5 ? 0 : -ScreenHeight() * 1.3)
                        
                    }
                    
                    .padding()
                        
                }

        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                for item in (1...6) {
                    withAnimation(.spring().delay(Double(item) * 0.03)){
                        self.animationInt += 1
                    }
                }
            }
        }
    }
}

struct Storage_Previews: PreviewProvider {
    static var previews: some View {
        Storage()
    }
}


struct RoomListRow: View {
    var roomname : String
    var visit : String
    var add : String
    var speak : String
    var quit : String
    var close : String
    var body: some View {
        HStack(alignment: .center, spacing: 12){
            
            Text(roomname)
                .lineLimit(1)
                .frame(width: ScreenWidth() * 0.16,alignment: .leading)
            
            Text(visit)
                .frame(width: ScreenWidth() * 0.1,alignment: .trailing)
            
            Text(add)
                .frame(width: ScreenWidth() * 0.1,alignment: .trailing)
            
            Text(speak)
                .frame(width: ScreenWidth() * 0.1,alignment: .trailing)
                .foregroundColor(.black.opacity(0.3))
            Text(close)
                .frame(width: ScreenWidth() * 0.1,alignment: .trailing)
                .foregroundColor(.orange)
            
            Text(quit)
                .frame(width: ScreenWidth() * 0.1,alignment: .trailing)
                .foregroundColor(.red)
            
            
        }
        .font(.system(size: 11, weight: .light, design: .monospaced))
    }
}





struct Message: View {
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 6){
                Text("7天网络数据")
                    .font(.system(size:14, weight: .light, design: .monospaced))
                HStack{
                    Text("/2492949访问")
                        .font(.system(size: 11, weight: .light, design: .monospaced))
                        .foregroundColor(.black.opacity(0.3))
                    Image(systemName: "arrow.up")
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .foregroundColor(.green)
                }
            }
            Spacer()
            PercentageData(PercentNumber: "2.98", showTag: true, showTagtext: true, tagName: "价格", tagColor:.red, unit: "%", tagIconType: .down)
            Spacer()
            PercentageData(PercentNumber: "1.1", showTag: true, showTagtext: true, tagName: "副本树", tagColor:.green, unit: "%", tagIconType: .up)
            Spacer()
            PercentageData(PercentNumber: "0.08", showTag: true, showTagtext: true, tagName: "新增节点", tagColor:.green, unit: "%", tagIconType: .up)
            
        }
        .mtCardStyle()
        
     
    }
}

struct ActiveUser: View {
    
    var body: some View {
        HStack{
            VStack(alignment:.center){
                Text("12")
                    .font(.system(size: 26, weight: .light, design: .monospaced))
                Text("有效文件")
                    .font(.system(size:12, weight: .light, design: .monospaced))
                    .foregroundColor(.black.opacity(0.3))
            }
            Spacer()
            PercentageData(PercentNumber: "29", showTag: true, tagName: "已用容量",tagColor: .blue)
            Spacer()
            PercentageData(PercentNumber: "71", showTag: true, tagName: "可用容量",tagColor: .green)
            Spacer()
            ZStack{

                ProgessCircle(frame: 40, color: .green, progress: 0.29,lineWidth: 6)
                ProgessCircle(frame: 40, color: .blue, progress: 0.71,lineWidth: 6)
                    .rotationEffect(Angle(degrees: 0.29 / 1 * 360))
            }
           
            
        }
        .mtCardStyle()
        
        
    }
}


struct Today: View {
    
    var body: some View {
        HStack(alignment:.center){
            Spacer()
            VStack(alignment:.center){
                Text("4958")
                    .font(.system(size: 26, weight: .light, design: .monospaced))
                Text("当前节点数")
                    .font(.system(size:12, weight: .light, design: .monospaced))
                    .foregroundColor(.black.opacity(0.3))
            }
            Spacer()
            Image("peers")
                .resizable()
                .scaledToFill()
                .frame(width: ScreenWidth() * 0.2)
            Spacer()
        }
        .mtCardStyle()
       
        
        
    }
}



struct ProgessCircle: View {
    
    var frame : CGFloat
    var color : Color
    var progress : CGFloat
    var lineWidth : CGFloat = 3
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), lineWidth: 3)
                .frame(width: frame, height: frame)
                .foregroundColor(.white)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(color,
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .frame(width: frame , height: frame)
        }
        .rotationEffect(Angle(degrees: 0))
    }
}



struct PercentageData: View {
    var PercentNumber : String
    var showTag : Bool = true
    var showTagtext : Bool = true
    var tagName : String
    var tagColor : Color = .green
    var unit : String = "%"
    var tagIconType : tagIconType = .defult
    
    enum tagIconType{
        case defult
        case up
        case down
    }
    var body: some View {
        VStack(alignment:.leading,spacing:4){
            
            HStack(spacing:6){
                if showTag {
                    switch self.tagIconType {
                    case .defult :
                        Capsule()
                            .frame(width: 4, height: 12)
                            .foregroundColor(tagColor)
                    case .up :
                        Image(systemName: "arrow.up")
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                            .foregroundColor(tagColor)
                    case .down :
                        Image(systemName: "arrow.down")
                            .font(.system(size: 12, weight: .medium, design: .monospaced))
                            .foregroundColor(tagColor)
                    }
                }
                if showTagtext{
                    Text(tagName)
                        .font(.system(size: 11, weight: .light, design: .monospaced))
                        .foregroundColor(.black.opacity(0.3))
                }
                
                
            }
            HStack(alignment: .bottom, spacing:4){
                Text(PercentNumber)
                    .font(.system(size:18, weight: .light, design: .monospaced))
                Text(unit)
                    .font(.system(size: 12, weight: .light, design: .monospaced))
                    .foregroundColor(.black.opacity(0.3))
            }
        }
    }
}

//
//struct SaveUser: View {
//
//    var body: some View {
//        HStack{
//            PercentageData(PercentNumber: "41", showTag: true, tagName: "次存留",tagColor: .yellow,unit: "%")
//            Spacer()
//            PercentageData(PercentNumber: "32", showTag: true, tagName: "7日",tagColor: .orange,unit: "%")
//            Spacer()
//            PercentageData(PercentNumber: "12", showTag: true, tagName: "15日",tagColor: .red,unit: "%")
//            Spacer()
//
//            ZStack{
//                ProgessCircle(frame: 15,color: .red, progress: 0.12)
//                ProgessCircle(frame: 28,color: .orange, progress: 0.32)
//                ProgessCircle(frame: 40,color: .yellow, progress: 0.41)
//            }
//        }
//
//        .padding(.all,12)
//        .background(Color.white)
//        .cornerRadius(12)
//        .padding(.horizontal,12)
//        .shadow(color: .black.opacity(0.02), radius: 6, x: 0, y: 0)
//
//    }
//}

//
//
//struct Search: View {
//    var body: some View {
//        HStack(alignment: .center, spacing: 12){
//            Image(systemName: "text.magnifyingglass")
//                .font(.system(size: 24, weight: .light, design: .serif))
//                .foregroundColor(.black.opacity(0.6))
//
//
//            VStack(alignment: .leading,  spacing:4){
//                Text("搜索/日活")
//                    .font(.system(size: 11, weight: .light, design: .monospaced))
//                Text("12.3%")
//                    .font(.system(size: 11, weight: .light, design: .monospaced))
//                    .foregroundColor(.black.opacity(0.3))
//            }
//
//            VStack(alignment: .leading,  spacing:4){
//                Text("光遇更新")
//                    .font(.system(size: 11, weight: .light, design: .monospaced))
//                    .foregroundColor(.black.opacity(0.3))
//                Text("米哈游")
//                    .font(.system(size: 11, weight: .light, design: .monospaced))
//                    .foregroundColor(.black.opacity(0.3))
//                Text("switch新机")
//                    .font(.system(size: 11, weight: .light, design: .monospaced))
//                    .foregroundColor(.black.opacity(0.3))
//            }
//            .padding(.leading,24)
//
//            Spacer()
//
//            VStack(alignment: .trailing,  spacing:4){
//                Text("hot in 5days")
//                    .font(.system(size: 11, weight: .light, design: .monospaced))
//                Text("开黑房间")
//                    .font(.system(size: 11, weight: .light, design: .monospaced))
//                    .foregroundColor(.black.opacity(0.3))
//            }
//            .padding(.leading,24)
//
//        }
//
//        .padding(.all,12)
//        .background(Color.white)
//        .cornerRadius(12)
//        .padding(.horizontal,12)
//        .shadow(color: .black.opacity(0.02), radius: 6, x: 0, y: 0)
//
//    }
//}

//
//struct Room: View {
//
//    var body: some View {
//
//        VStack(alignment: .leading, spacing: 6){
//            HStack(alignment: .bottom){
//                VStack(alignment: .leading, spacing: 6){
//                    Text("Room")
//                        .font(.system(size:14, weight: .light, design: .monospaced))
//                    Text("/2309V/3929J")
//                        .font(.system(size: 11, weight: .light, design: .monospaced))
//                        .foregroundColor(.black.opacity(0.3))
//                }
//                Spacer()
//                VStack(alignment: .trailing, spacing: 6){
//                    Text("活跃房间")
//                        .font(.system(size: 11, weight: .light, design: .monospaced))
//                        .foregroundColor(.black.opacity(0.3))
//                    Text("322/23994")
//                        .font(.system(size:14, weight: .light, design: .monospaced))
//                }
//                RoundedRectangle(cornerRadius: 4)
//                    .foregroundColor(.black.opacity(0.5))
//                    .frame(width: 16)
//                    .overlay(
//                        VStack{
//                            Spacer()
//                            RoundedRectangle(cornerRadius: 4)
//                                .foregroundColor(.green)
//                                .frame(height: 12)
//                        }
//
//                    )
//            }
//
//            Divider()
//                .padding(.vertical,3)
//
//            VStack(alignment: .leading, spacing: 16) {
//                HStack(alignment: .center, spacing: 12){
//                    Text("")
//                        .lineLimit(1)
//                        .frame(width: ScreenWidth() * 0.16,alignment: .leading)
//                    Text("访问V")
//                        .frame(width: ScreenWidth() * 0.1,alignment: .trailing)
//
//                    Text("加入J")
//                        .frame(width: ScreenWidth() * 0.1,alignment: .trailing)
//
//                    Text("发言S")
//                        .foregroundColor(.black.opacity(0.3))
//                        .frame(width: ScreenWidth() * 0.1,alignment: .trailing)
//                    Text("免扰C")
//                        .frame(width: ScreenWidth() * 0.1,alignment: .trailing)
//
//                    Text("退出Q")
//                        .foregroundColor(.black.opacity(0.3))
//                        .frame(width: ScreenWidth() * 0.1,alignment: .trailing)
//                }
//                .font(.system(size: 11, weight: .light, design: .monospaced))
//                ForEach(0 ..< 5) { item in
//                    let i = item + 2
//                    let roomname = ["测试房","王者荣耀","永劫无间（）","明日方舟","综合游戏讨论区"]
//                    RoomListRow(roomname: roomname[item], visit: "\(i * 127)", add: "\(i * 129)", speak: "\(i * 294)", quit: "\(i * 39)", close: "\(i * 2)")
//                }
//            }
//            .padding(.top,6)
//
//
//
//        }
//        .padding()
//        .background(Color.white)
//        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
//        .shadow(color: .black.opacity(0.06), radius: 16, x: 0, y: 0)
//    }
//}


