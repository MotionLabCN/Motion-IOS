//
//  NotificationView.swift
//  NotificationView
//
//  Created by Liseami on 2021/9/15.
//

import MotionComponents

struct NotificationView: View {
    var body: some View {
        VStack{
            
     
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack{
                ForEach(0 ..< 50) { item in
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
            }
        }
        .mtAttatchTabbarSpacer()
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
