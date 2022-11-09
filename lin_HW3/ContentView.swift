//
//  ContentView.swift
//  lin_HW3
//
//  Created by User01 on 2022/11/9.
//

import SwiftUI

struct ContentView: View {
    @State var mainColor = Color.red
    var body: some View {
        ZStack{
            mainColor.ignoresSafeArea()
            VStack{
                Text("高鐵訂票系統").bold().font(.title)
                TabView{
                    BookingView()
                        .tabItem { Image(systemName: "ticket")
                            Text("訂票") }
//                    HistoryView()
//                        .tabItem { Image(systemName: "clock")
//                            Text("紀錄") }
                    SettingView(mainColor:$mainColor)
                        .tabItem { Image(systemName: "gear")
                            Text("設定")
                        }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
