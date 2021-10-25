//
//  LibraryDetail.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents
import Kingfisher


struct LibraryDetail: View {
    @State var offset : CGFloat = 0
    let item : OpenSourceLibraryModel
    
    // For Dark Mode Adoption..
    @Environment(\.colorScheme) var colorScheme
    
    @State var currentTab = "介绍"
    
    // For Smooth Slide Animation...
    @Namespace var animation
    
    @State var tabBarOffset: CGFloat = 0
    
    @State var titleOffset: CGFloat = 0
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false, content: {
            
            VStack(spacing: 15){
                
                
                headerView
                
                VStack(spacing:0){
                    
                    
                    avatarImage
                    
                    infos
                    
                    tabBtns
                    
                    pageView
                    
                }
                .padding(.horizontal)
                .zIndex(-offset > 80 ? 0 : 1)
            }
        })
            .ignoresSafeArea(.all, edges: .top)
    }
    
    @ViewBuilder
    var pageView : some View {
        switch currentTab {
        case "介绍" :
            Color.white.frame(width: ScreenWidth(), height: ScreenHeight())
                .overlay(MTWebView(urlString: item.htmlUrl))
        case "评论":
            MTDescriptionView(title: "暂无评论", subTitle: "开源库的评论会显示在这里。")
                .padding(.top,56)
        default :
            MTDescriptionView(title: "暂无实践", subTitle: "最佳实践会显示在这里。")
                .padding(.top,56)
        }
    }
    
    var avatarImage : some View{
        KFImage(URL(string: item.avatarUrl))
            .resizable()
            .placeholder({Color.black.overlay(ProgressView())})
            .aspectRatio(contentMode: .fill)
            .frame(width: 75, height: 75)
            .clipShape(Circle())
            .padding(8)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .clipShape(Circle())
            .offset(y: offset < 0 ? getOffset() - 20 : -20)
            .scaleEffect(getScale())
            .padding(.top,-25)
            .padding(.bottom,-10)
    }
    var infos : some View {
        VStack(alignment: .center, spacing: 8, content: {
            
            Text(item.name)
                .font(.mt.title2.mtBlod(),textColor: .mt.gray_800)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            HStack(spacing: 5){
                Text(item.fullName)
                    .font(.mt.body2,textColor: .mt.gray_800)
                Text(item.forksCount)
                    .font(.mt.body2,textColor: .mt.gray_800)
                Text("Stars")
                    .font(.mt.body2,textColor: .mt.gray_800)
            }
            .padding(.top,8)
            
            
            Text("开源库的介绍文案，能不能拿到Readme的前10行字。开源库的介绍文案，能不能拿到Readme的前10行字。")
                .font(.mt.body2,textColor: .mt.gray_800)
                .padding(.horizontal,42)
            
            
            HStack{
                Image.mt.load(.Github)
                Text(item.htmlUrl)
                    .font(.mt.body2.mtBlod(),textColor: .mt.accent_700)
                    .lineLimit(1)
            }
        })
            .overlay(
                
                GeometryReader{proxy -> Color in
                    
                    let minY = proxy.frame(in: .global).minY
                    
                    DispatchQueue.main.async {
                        self.titleOffset = minY
                    }
                    return Color.clear
                }
                    .frame(width: 0, height: 0) ,alignment: .top)
    }
    
    var tabBtns : some View {
        HStack(spacing: 0){
            Spacer()
            TabButton(title: "介绍", currentTab: $currentTab, animation: animation)
            Spacer()
            TabButton(title: "评论", currentTab: $currentTab, animation: animation)
            Spacer()
            TabButton(title: "最佳实践", currentTab: $currentTab, animation: animation)
            Spacer()
        }
        .frame(width: ScreenWidth())
        .overlay(Divider(),alignment: .bottom)
        .padding(.top,30)
        .background(Color.white)
        .offset(y: tabBarOffset < 90 ? -tabBarOffset + 90 : 0)
        .overlay(
            GeometryReader{reader -> Color in
                let minY = reader.frame(in: .global).minY
                
                DispatchQueue.main.async {
                    self.tabBarOffset = minY
                }
                
                return Color.clear
            }
                .frame(width: 0, height: 0)
            
            ,alignment: .top
        )
        .zIndex(1)
    }
    var headerView : some View {
        // Header View...
        GeometryReader{proxy -> AnyView in
            
            // Sticky Header...
            let minY = proxy.frame(in: .global).minY
            
            DispatchQueue.main.async {
                self.offset = minY
            }
            
            return AnyView(
                
                ZStack{
                    
                    // Banner...
                    KFImage(URL(string: item.avatarUrl))
                        .resizable()
                        .placeholder({
                            Color.mt.accent_800
                        })
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRect().width, height: minY > 0 ? 180 + minY : 180, alignment: .center)
                        .cornerRadius(0)
                    
                    BlurView()
                        .opacity(blurViewOpacity())
                    
                    // Title View...
                    VStack(spacing: 5){
                        
                        Text(item.name)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("\(item.forksCount) Stars")
                            .foregroundColor(.white)
                    }
                    // to slide from bottom added extra 60..
                    .offset(y: 120)
                    .offset(y: titleOffset > 100 ? 0 : -getTitleTextOffset())
                    .opacity(titleOffset < 100 ? 1 : 0)
                }
                    .clipped()
                // Stretchy Header...
                    .frame(height: minY > 0 ? 180 + minY : nil)
                    .offset(y: minY > 0 ? -minY : -minY < 80 ? 0 : -minY - 80)
            )
        }
        .frame(height: 180)
        .zIndex(1)
    }
    
    func getTitleTextOffset()->CGFloat{
        let progress = 20 / titleOffset
        let offset = 60 * (progress > 0 && progress <= 1 ? progress : 1)
        return offset
    }
    
    
    func getOffset()->CGFloat{
        let progress = (-offset / 80) * 20
        return progress <= 20 ? progress : 20
    }
    
    func getScale()->CGFloat{
        let progress = -offset / 80
        let scale = 1.8 - (progress < 1.0 ? progress : 1)
        return scale < 1 ? scale : 1
    }
    
    func blurViewOpacity()->Double{
        let progress = -(offset + 80) / 150
        return Double(-offset > 80 ? progress : 0)
    }
    
    
    struct TabButton: View {
        var title: String
        @Binding var currentTab: String
        var animation: Namespace.ID
        var body: some View{
            Button(action: {
                withAnimation{
                    currentTab = title
                }
            }, label: {
                LazyVStack(spacing: 12){
                    Text(title)
                        .font(.mt.body1.mtBlod(),textColor: currentTab == title ? Color.mt.accent_800 : .mt.gray_500)
                        .foregroundColor(currentTab == title ? .blue : .gray)
                        .padding(.horizontal)
                    
                    if currentTab == title{
                        Capsule()
                            .fill(Color.mt.accent_800)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                    else{
                        Capsule()
                            .fill(Color.clear)
                            .frame(height: 1.2)
                    }
                }
            })
        }
    }
}

struct LibraryDetail_Previews: PreviewProvider {
    static var previews: some View {
        LibraryDetail(item: OpenSourceLibraryModel(avatarUrl: "394239", categoryId: "2", cloneUrl: "2394i234", createdAt: "3294i234", description: "32942i3492", forksCount: "23942394", fullName: "ewr29392", htmlUrl: "329492394", id: "3249239", language: "dsjfadsnfdaj", login: "sdjfaijd", name: "djsfijaisdfj", pushedAt: "dijfaj", reposId: "jdsfija`", size: "sdijfaijsdfji", starCount: "sdjfaijsdfi", topics: "jdsifjai", updatedAt: "jdisijf"))
    }
}


extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}
