//
//  SettingView.swift
//  lin_HW3
//
//  Created by User01 on 2022/11/9.
//

import SwiftUI
import AVKit

struct SettingView: View {
    @Binding var mainColor : Color
    @State var name = ""
    @State var age : Double = 20
    @State var payment = "超商付款"
    @State var showingOptions = false
    @State var gender = "選擇性別"
    @State private var message = ""
    @State private var showAlert = false
    @State var sheet = false
    @State var cover = false
    @State private var isPlay = false
    let player = AVPlayer()
    var body: some View {
        Form
        {
            DisclosureGroup("個人資料"){
                VStack{
                    HStack{
                        Text("姓名：")
                        TextField("輸入姓名", text: $name)
                    }
                    Divider()
                    HStack{
                        Text("姓別：")
                        Text("\(gender)")
                            .contextMenu(menuItems: {
                                Button {
                                    gender = "男生"
                                } label: {
                                    Label("男生", systemImage: "person")
                                }
                                
                                Button {
                                    gender = "女生"
                                } label: {
                                    Label("女生", systemImage: "person")
                                }
                            })
                    }
                    Divider()
                    Text("年齡：\(Int(age))")
                    Slider(value: $age, in: 1...120, step: 1, minimumValueLabel: Text("1"), maximumValueLabel: Text("120")) {
                        Text("age")
                    }
                }
            }
            DisclosureGroup("付款方式"){
                HStack{
                    Text("慣用付款方式：\(payment)")
                    Button("變更") {
                        showingOptions = true
                    }
                    .actionSheet(isPresented: $showingOptions) {
                        ActionSheet(
                            title: Text("選擇付款方式"),
                            buttons: [
                                .default(Text("超商付款")) {
                                    payment = "超商付款"
                                },
                                
                                .default(Text("信用卡付款")) {
                                    payment = "信用卡付款"
                                },
                            ]
                        )
                    }
                }
            }
            DisclosureGroup("系統設定"){
                ColorPicker("設定主要顏色", selection: $mainColor)
            }
            DisclosureGroup("用戶回饋"){
                Text("請寫下你的回饋")
                TextEditor(text: $message)
                    .frame(width: 300, height: 200)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                Button(action:
                        {
                            showAlert = true
                            message = ""
                        },
                       label:
                        {
                            Text("送出")
                        }
                )
                .alert(isPresented: $showAlert, content: {
                    return Alert(title: Text("收到回饋"), message:
                                    Text("謝謝你的支持"))
                })
            }
            DisclosureGroup("開發者資訊"){
                Button("點擊查看") {
                    sheet = true
                    let url = Bundle.main.url(forResource: "Music", withExtension: "mp3")!
                    let playerItem = AVPlayerItem(url: url)
                    player.replaceCurrentItem(with: playerItem)
                }
                .sheet(isPresented: $sheet, content: {
                    Text("開發者名稱：林佳何")
                    Toggle("開發者推薦的音樂 播放", isOn: Binding(get: {
                        isPlay
                    }, set: {
                        isPlay = $0
                        if isPlay {
                            player.play()
                        } else {
                            player.pause()
                        }
                    }))
                    Button("全螢幕顯示") {
                        cover = true
                    }
                    .fullScreenCover(isPresented: $cover, content: {
                        HStack{
                            Text("開發者名稱：")
                            Text("林佳何")
                        }
                        Toggle("開發者推薦的音樂 播放", isOn: Binding(get: {
                            isPlay
                        }, set: {
                            isPlay = $0
                            if isPlay {
                                player.play()
                            } else {
                                player.pause()
                            }
                        }))
                        Button("返回"){
                            cover = false
                        }
                    })
                })
            }
        }
    }
}


