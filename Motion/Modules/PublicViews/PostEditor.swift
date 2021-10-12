//
//  PostEditor.swift
//  Motion
//
//  Created by Liseami on 2021/9/23.
//

import SwiftUI

struct PostEditor: View {
    @State private var posttext : String = ""
    var body: some View {

        HStack(alignment: .top, spacing: 12){
            MTLocUserAvatar( frame: 44)
            TextEditor(text: $posttext)
                .font(.mt.body1)
                .foregroundColor(.mt.gray_900)
            
        }.padding()
     
    }
}

struct PostEditor_Previews: PreviewProvider {
    static var previews: some View {
        PostEditor()
    }
}
