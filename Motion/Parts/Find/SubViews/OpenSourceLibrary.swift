//
//  OpenSourceLibrary.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI
import MotionComponents
import Kingfisher

//MARK: View
struct OpenSourceLibrary: View {
    
    @State private var isShowCategory: Bool = false //显示语言
    @StateObject private var vm = OpenSourceLibraryVm()
    @Binding var isOpenLoading: Bool 
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing:16){
                classic
                newStar
            }.padding(.top,16)
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $isShowCategory) {
            CategoryItemList
        }
        .mtTopProgress(vm.isLoading)
    }

    
// MARK: 开源热门语言弹框
    @ViewBuilder
    var CategoryItemList : some View {
        let cardWidth = (ScreenWidth() - 40 - 20 ) / 3
        //排序方式
        let columns = Array(repeating:  GridItem(.fixed(cardWidth)), count: 3)

        NavigationView {
            ScrollView {
                // 网格列表
                LazyVGrid(columns: columns,
                          alignment: .center,
                          spacing: 20,
                          content: {
                    LangListView
                })
            }
            .listStyle(.grouped)
            .navigationBarTitle(Text("热门分类"))
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: closeBtn)
            .mtTopProgress(vm.isLoadingCategory)
        }
        .onAppear {
            // 每次出现调用接口
            vm.requestWithCategoryList()
        }
    }

    //MARK: 分类语言view
    var LangListView: some View {
        ForEach(vm.categoryList) { item in
            HStack {
                Text(item.name)
                    .font(.mt.body1, textColor: item.isSelect ? .blue: .mt.gray_900)
                    .frame(height:40)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.mt.gray_200)
            )
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(item.isSelect ? Color.blue : .mt.gray_200, lineWidth: 1)
            )
            .contentShape(Rectangle())
            .onTapGesture(perform: {
                // 选中和取消
                isShowCategory.toggle()
                vm.updateLangItems(item: item)
            })
        }
    }
    
    var closeBtn : some View {
        Button {
            isShowCategory.toggle()
        } label: {
            Image.mt.load(.Close)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .foregroundColor(Color.black)
        .padding(.all,4)
        .background(Color.mt.gray_100)
        .clipShape(Circle())
        .frame(maxWidth:.infinity,alignment: .trailing)
    }
    
    @ViewBuilder
    var newStar : some View {
        
        Section {
            //            Button("获取"){
            //                vm.request()
            //            }
            //            Text("\(vm.newStarList.count)")
            if vm.newStarList.isEmpty{ProgressView()}
            else{
                ForEach(vm.newStarList,id: \.id) { item in
                    NavigationLink {
                        LibraryDetail(item: item)
                    } label: {
                        LibraryListCell(item: item)
                            .padding(.horizontal)
                    }
                    
                    Divider()
                }
            }
        } header: {
            Text("新星")
                .font(.mt.title2.mtBlod(),textColor: .black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
    
    var classic: some View{
        Section {
            if vm.hotList.isEmpty{ProgressView()}
            else{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing:16){
                        ForEach(vm.hotList ,id: \.id) { item in
                            VStack(alignment: .leading,spacing:4){
                                NavigationLink {
                                    LibraryDetail(item: item)
                                } label: {
                                    KFImage(URL(string: item.avatarUrl))
                                        .resizable()
                                        .placeholder({Color.mt.gray_400})
                                        .scaledToFill()
                                        .frame(width: ScreenWidth() / 3, height: ScreenWidth() / 3 * 1.4)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .foregroundColor(.random)
                                }
                                Text(item.name)
                                    .font(.mt.body2.mtBlod(),textColor: .black)
                                Text(item.forksCount)
                                    .font(.mt.body2.mtBlod(),textColor: .mt.accent_800)
                            }
                        }
                    }.padding(.horizontal)
                }
            }
        } header: {
            HStack {
                Text("热门")
                    .font(.mt.title2.mtBlod(),textColor: .black)
                Spacer()
                Button {
                    isShowCategory.toggle()
                    
                } label: {
                    Text(vm.categoryName)
                        .font(.mt.title3.mtBlod(),textColor: .red)
                    Image.mt.load(.Filter_list)
                }
            }
            .padding(.horizontal)
        }
    }
}

//struct OpenSourceLibrary_Previews: PreviewProvider {
//    static var previews: some View {
//        let isOpenLoading: Bool = false
//        OpenSourceLibrary(isOpenLoading: $isOpenLoading)
//    }
//}

struct LibraryListCell: View {
    
    var item : OpenSourceLibraryModel
    var body: some View {
        
        HStack{
            KFImage(URL(string: item.avatarUrl))
                .resizable()
                .placeholder({
                    Color.mt.gray_200
                })
                .scaledToFill()
                .frame(width: ScreenWidth() / 6, height: ScreenWidth() / 6)
                .clipShape(Capsule(style: .continuous))
                .foregroundColor(.random)
            VStack(alignment: .leading, spacing: 6){
                Text(item.name)
                    .font(.mt.body1.mtBlod(),textColor: .mt.gray_900)
                Text(item.fullName)
                    .font(.mt.caption1.mtBlod(),textColor: .mt.gray_600)
                HStack{
                    Circle().frame(width: 12, height: 12)
                    Circle().frame(width: 12, height: 12)
                    Circle().frame(width: 12, height: 12)
                    Circle().frame(width: 12, height: 12)
                    Circle().frame(width: 12, height: 12)
                    Text("\(item.forksCount)个Star")
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
