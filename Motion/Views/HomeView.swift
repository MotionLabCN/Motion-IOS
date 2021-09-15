//
//  HomeView.swift
//  Motion
//
//  Created by 梁泽 on 2021/9/15.
//

import SwiftUI

struct HomeView: View {

    
    var body: some View {
        List(0..<50) { index in
            NavigationLink(destination: HomeSecondView()) {
                Text("\(index)")

            }
        }
    }
}

struct HomeSecondView: View {
    @EnvironmentObject var router: AppState.TopRouterTable

    
    var body: some View {
        VStack {
            NavigationLink("self", destination: HomeSecondView())
            
            List(0..<50) { index in
                Button("index \(index)") {
                    if index.isPrime() {
                        router.linkurl = true
                    } else {
                        router.messageDetail = true

                    }
                }
            }
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
