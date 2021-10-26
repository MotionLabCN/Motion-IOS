//
//  NewStorageView.swift
//  Motion
//
//  Created by Liseami on 2021/10/19.
//

import SwiftUI
import MotionComponents

public var storageViewTabs = ["存储","盈利"]


struct NewStorageView: View {
    @State var offset : CGFloat = 0
    // vm
    @StateObject var vm = StorageViewModel()
    
    var body: some View {
        
        VStack(spacing:0){
            MTPageSegmentView(titles: storageViewTabs, offset: $offset)
            MTPageScrollView(offset: $offset) {
                HStack(spacing: 0) {
                    Group {
                        storage
                        JoinPeerView(vm: vm)
//                       Text("天天数链/计算模块/开发中")
                    }
                    .frame(width: ScreenWidth())
                }
            }
        }
        .frame(width: ScreenWidth())
        .mtNavbar(content: {
            Capsule().frame(width: 255, height: 32)
                .foregroundColor(.mt.gray_200)
                .overlay(HStack{
                    Image.mt.load(.Search)
                        .frame(width: 16, height: 16)
                    Text("搜索Motion")
                        .font(.mt.body3 )
                } .foregroundColor(.mt.gray_500)
                )
        }, leading: {
            MTLocUserAvatar()
        }, trailing: {
            SettingBtn()
        })
        .mtTopProgress(vm.isLoading, usingBackgorund: false)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $vm.isShowmtDetail) {
            StorageListView()
        }
    }
    
    @ViewBuilder
    var storage : some View {
        
        ScrollView(.vertical, showsIndicators: false){
            let w = CGFloat( ScreenWidth() / 2.2)
            let columns = Array(repeating:GridItem(.flexible(minimum: w, maximum: w) , spacing: 12), count: 2)
            LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
                infoCard("全网节点数",vm.storageModel?.totalStorageMessage.mtCurrencyWithInt() ?? "0",.Dial_numbers)
                infoCard("有效文件数",vm.storageModel?.validFilesNumber.mtCurrencyWithInt() ?? "0",.Group_folders)
                infoCard("平均副本数",vm.storageModel?.averageReplicasMessage.mtCurrencyWithInt() ?? "0",.Selected_file)
                infoCard("已用存储量",vm.storageModel?.usedStorageMessage.mtCurrencyWithInt() ?? "0",.Box)
            }
            .padding()
            
            Section {
                if vm.storageList.count > 0 {
                    Text("sss")
                } else {
                    Spacer().frame(width: 0, height: ScreenHeight() * 0.1)
                    MTDescriptionView(title: "尚未存储任何文件", subTitle: "你存储的文件将会显示在这里。")
                    Spacer()
                }
                
            }
        header: {
            HStack {
                Text("我的存储")
                    .font(.mt.title2.mtBlod(),textColor: .black)
                Spacer()
                Image.mt.load(.Add)
                    .foregroundColor(.mt.accent_800)
            }
            .padding(.horizontal)
        }
            Spacer()
        }
    }
    
    @ViewBuilder
    func infoCard(_ text: String,_ number : String,_ iconName : MTDiskIcon) -> some View  {
        VStack(alignment: .leading, spacing:12){
            Image.mt.load(iconName)
                .resizable()
                .frame(width: 36, height: 36)
                .scaledToFit()
            VStack(alignment: .leading, spacing:4){
                Text(text)
                    .font(.mt.body3, textColor: .mt.gray_700)
                 Text(number)
                    .font(.mt.title2.mtBlod() , textColor: .black)
                    .lineLimit(1)
            }
        
        }
        .padding()
        .frame(width: ScreenWidth() / 2.2,alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .shadow(color: .mt.gray_200, radius: 8, x: 0, y: 0)
    }
}

struct NewStorageView_Previews: PreviewProvider {
    static var previews: some View {
        NewStorageView()
    }
}


struct JoinPeerView: View {
    var vm = StorageViewModel()
    var body: some View {
        VStack{
            Spacer()   .frame(height: ScreenWidth() * 0.1)
            Capsule(style: .continuous)
                .fill(Color.random)
                .frame(width: ScreenWidth() * 0.6, height: ScreenWidth() * 0.6)
            VStack(spacing:12){
                MTDescriptionView(title: "节点盈利", subTitle: "基于去中心化的分布式存储协议，享受存储服务的同时，有机会为他人提供存储空间，以获取收益。")
                Button("加入存储节点"){
                    vm.isShowmtDetail.toggle()
                }
                .mtButtonStyle(.mainGradient)
                .padding(.horizontal,42)
                .padding(.vertical,16)
                
            }
            .padding(.vertical,44)
        }
    }
}
