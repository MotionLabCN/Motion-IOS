//
//  OpenSourceLibrary.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents

private typealias Image = SwiftUI.Image
struct  OpenSourceLibraryModel: Identifiable, Convertible {
    var avatarUrl = ""
    var categoryId = ""
    var cloneUrl = ""
    var createdAt = ""
    var description = ""
    var forksCount = ""
    var fullName = ""
    var htmlUrl = ""
    var id = ""
    var language = ""
    var login = ""
    var name = ""
    var pushedAt = ""
    var reposId = ""
    var size = ""
    var starCount = ""
    var topics = ""
    var updatedAt = ""
}

enum OpenSourceLibraryApi : MTTargetType{
    var path: String {
        switch self {
        case .hotlist:
            return "api/gateway/motion-community/github/repository/hot"
        case .newstar:
            return "/api/gateway/motion-community/github/repository/newstar"
        }
    }
    
    case hotlist(p:hotlistParameters)
    case newstar(p:hotlistParameters)
}


extension OpenSourceLibraryApi{
    struct hotlistParameters:Convertible{
        var pageNum = 1
        var pageSize = 10
        var categoryId = 2
    }
}


class OpenSourceLibraryVm : ObservableObject{
    
    @Published var hotList : [OpenSourceLibraryModel] = []
    @Published var newStarList : [OpenSourceLibraryModel] = []
    
    init(){
        request()
    }
    func request(){
        let hotlist = OpenSourceLibraryApi.hotlist(p: .init(pageNum: 0, pageSize: 30, categoryId: 2))
        let newstar = OpenSourceLibraryApi.newstar(p: .init(pageNum: 0, pageSize: 30, categoryId: 2))
        Networking.requestArray(hotlist, modeType: OpenSourceLibraryModel.self, atKeyPath: "data.list") { [weak self] r, list in
            guard let self = self else{
                return
            }
            if let list = list{
                self.hotList.append(contentsOf: list)
            }else{
                
            }
        }
        Networking.requestArray(newstar, modeType: OpenSourceLibraryModel.self, atKeyPath: "data.list") { [weak self] r, list in
            guard let self = self else{
                return
            }
            if let list = list{
                self.newStarList.append(contentsOf: list)
            }else{
                
            }
        }
    }
}

struct OpenSourceLibrary: View {
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing:16){
                
                classic
                newStar
                
            }.padding(.top,16)
        }
    }
    
    
    
    
    var newStar : some View {
        Section {
            ForEach(0 ..< 50) { item in
                LibraryListCell()
                    .padding(.horizontal)
                Divider()
            }
        } header: {
            Text("新星")
                .font(.mt.title2.mtBlod(),textColor: .black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
    
    var classic : some View{
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:16){
                    ForEach(0 ..< 5) { item in
                        VStack(alignment: .leading,spacing:4){
                            NavigationLink {
                                LibraryDetail()
                            } label: {
                                Rectangle().frame(width: ScreenWidth() / 3, height: ScreenWidth() / 3 * 1.4)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .foregroundColor(.random)
                            }
                            Text("SpringBoot")
                                .font(.mt.body2.mtBlod(),textColor: .black)
                            Text("8.9")
                                .font(.mt.body2.mtBlod(),textColor: .mt.accent_800)
                        }
                        
                    }
                }.padding(.horizontal)
            }
        } header: {
            HStack {
                Text("热门")
                    .font(.mt.title2.mtBlod(),textColor: .black)
                Spacer()
                Text("Swift")
                    .font(.mt.title3.mtBlod(),textColor: .red)
                Image.mt.load(.Filter_list)
            }
            .padding(.horizontal)
        }
    }
}

struct OpenSourceLibrary_Previews: PreviewProvider {
    static var previews: some View {
        OpenSourceLibrary()
    }
}

struct LibraryListCell: View {
    var body: some View {
        
        HStack{
            Rectangle()
                .frame(width: ScreenWidth() / 6, height: ScreenWidth() / 6)
                .clipShape(Capsule(style: .continuous))
                .foregroundColor(.random)
            VStack(alignment: .leading, spacing: 6){
                Text("OpenStack Swift")
                    .font(.mt.body1.mtBlod(),textColor: .mt.gray_900)
                Text("分布式对象存储系统")
                    .font(.mt.caption1.mtBlod(),textColor: .mt.gray_600)
                HStack{
                    Circle().frame(width: 12, height: 12)
                    Circle().frame(width: 12, height: 12)
                    Circle().frame(width: 12, height: 12)
                    Circle().frame(width: 12, height: 12)
                    Circle().frame(width: 12, height: 12)
                    Text("29492个评分")
                        .font(.mt.body2,textColor: .mt.gray_600)
                }
                .foregroundColor(.mt.gray_600)
                
            }
            Spacer()
        }
    }
}

struct MoneyNotiView: View {
    @State private var showLottie : Bool = true
    var body: some View {
        Button {
            ()
        } label: {
            HStack(alignment: .top, spacing: 16){
                Color.mt.gray_100
                    .frame(width: 56, height: 56)
                    .clipShape(Capsule(style: .continuous))
                    .overlay(MTLottieView(lottieFliesName: "moneyIcon", loopMode:.repeat(2)).padding(.all,3))
                
                VStack(alignment: .leading,spacing:8){
                    Text("尝试盈利！")
                        .font(.mt.body1.mtBlod(),textColor: .black)
                    Text("你在Motion中的盈利的三种方式，现已开放测试。")
                        .font(.mt.body2,textColor: .mt.gray_600)
                        .lineSpacing(8)
                }
                Spacer()
                VStack{
                    Image.mt.load(.Chevron_right_On)
                        .foregroundColor(.mt.gray_400)
                }
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle.init(cornerSize: CGSize(width: 18, height: 24), style: .continuous))
            .mtShadow(type: MTShadow.shadowLow)
            .padding()
            .overlay(
                Group{
                    if showLottie{
                        MTLottieView(lottieFliesName: "money-falling", loopMode: .loop)
                            .transition(.opacity)
                    }
                }
            )
            
        }
        .transition(.fly.animation(.spring()))
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation{
                    showLottie = false
                }
            }
        })
        
        
    }
}
