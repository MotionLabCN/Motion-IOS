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
    @State private var  selectedPhotos : [UIImage] = []
    @State private var text : String = ""
    @State private var  onelineheihgt : CGFloat = 0
    var body: some View {
   
            
            
            HStack(alignment: .top, spacing:12){
                

  MTLocUserAvatar()
                VStack(alignment: .leading,spacing:12){
                    
              
                    
                    
                    TextEditor(text: $text)
                        .lineSpacing(8)
                        .frame( height: onelineheihgt * 5)
                        .padding(.trailing,24)
                        .offset(x : -4)
                        .overlay(
                            Group(content: {
                                if text.count == 0{
                                    Text("今天说点什么？")
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
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(alignment: .top, spacing: 12){
                            
                            Button {
                                showPhotoPicker = true
                            } label: {
                                RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(lineWidth: 0.5).foregroundColor(.mt.gray_400)
                                    .frame(width: 72, height: 72)
                                    .overlay(Image.mt.load(.Person))
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
                        .frame(alignment: .leading)
                    }
                    Spacer()
                }
            }
        
            .padding(.top,ScreenHeight() * 0.1)
            .padding(.leading,24)
            .sheet(isPresented: $showPhotoPicker) {
                SystemImagePicker(selectionLimit:  9 - selectedPhotos.count, show: $showPhotoPicker, isloading: $isLoading) { uiimages in
                    for uiimage in uiimages {
                        selectedPhotos.append(uiimage)
                    }
                }
                .ignoresSafeArea()
                .overlay(Group{if isLoading {ProgressView()}})
            }

    }
}

struct PostEditorView_Previews: PreviewProvider {
    static var previews: some View {
        PostEditorView()
    }
}
