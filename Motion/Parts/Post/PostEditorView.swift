//
//  PostEditorView.swift
//  Motion
//
//  Created by Liseami on 2021/10/18.
//

import SwiftUI
import MotionComponents



public struct IDImage : Identifiable,Equatable{
    public let id = UUID()
    let image : Image
}


struct PostEditorView: View {
    @State private var showPhotoPicker : Bool = false
    @State private var isLoading : Bool = false
    @State private var selectedPhotos : [UIImage] = []
    @State private var text : String = ""
    private let  maxCount = 9
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            topToolbar
                .frame(height: 50)
                .padding(.top, 24)
            
            HStack(alignment: .top, spacing:12){
                MTLocUserAvatar()
                
                TextEditor(text: $text)
                    .font(.mt.body1)
                    .lineSpacing(8)
                    .background(Color.random)
                    .overlay(
                        Group(content: {
                            if text.isEmpty {
                                Text("今天说点什么？")
                                    .font(.mt.body1, textColor: .mt.gray_700)
                                    .offset(x: 2, y: 9)
                                    .animation(.spring())
                                    .transition(.opacity)
                                    
                            }
                        })
                        ,alignment: .topLeading
                    )
                    .introspectTextView { UITextView in
                        UITextView.becomeFirstResponder()
                    }
            }
            .padding(.top, 24)
            .padding(.horizontal, 24)
            
            bottomToolbar
            
        }
        
        
        .sheet(isPresented: $showPhotoPicker) {
            SystemImagePicker(selectionLimit:  maxCount - selectedPhotos.count, show: $showPhotoPicker, isloading: $isLoading) { uiimages in
                for uiimage in uiimages {
                    selectedPhotos.append(uiimage)
                }
            }
            .ignoresSafeArea()
            .overlay(Group{if isLoading {ProgressView()}})
        }
        
    }
    
    var topToolbar: some View {
        HStack {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("取消")
                    .font(.mt.body1, textColor: .mt.gray_700)
            }
            
            Spacer()
            
            Button {
                
                print("text = \(text), photos count = \(selectedPhotos.count)")
            } label: {
                Text("发布")
                    .font(.mt.body1, textColor: .mt.accent_purple)
            }

        }
        .padding(.horizontal, 12)
    }
    
    @ViewBuilder
    var bottomToolbar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 12){
                if selectedPhotos.count < maxCount {
                    Button {
                        showPhotoPicker = true
                    } label: {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(lineWidth: 0.5)
                            .foregroundColor(.mt.gray_400)
                            .frame(width: 72, height: 72)
                            .overlay(
                                Image.mt.load(.Add)
                                    .foregroundColor(.mt.accent_purple)
                            )
                        
                    }
                }
              
                
                if  selectedPhotos.count != 0 {
                    let images = selectedPhotos.map{ image in
                        IDImage(image: Image(uiImage: image))
                    }
                    ForEach(images, id :\.id){  image in
                        image.image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 72, height: 72)
                            .transition(.fly.animation(.spring()))
                            .clipShape( RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .overlay( RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(lineWidth: 0.5).foregroundColor(.mt.gray_400))
                            .contentShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .contextMenu(ContextMenu(menuItems:
                                                        {
                                Button("删除"){
                                    withAnimation(.spring()){
                                        if let index = images.firstIndex(of:  image ){
                                            selectedPhotos.remove(at: index)
                                        }
                                    }
                                }
                            }
                                                    ))
                        
                    }
                }
                
               
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
            
           
        }

    }
    
}

struct PostEditorView_Previews: PreviewProvider {
    static var previews: some View {
        PostEditorView()
    }
}
