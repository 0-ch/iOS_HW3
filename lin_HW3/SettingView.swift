//
//  SettingView.swift
//  lin_HW3
//
//  Created by User01 on 2022/11/9.
//

import SwiftUI

struct SettingView: View {
    @Binding var mainColor : Color
    @State var name = ""
    @State var age : Double = 20
    @State var gender = "選擇性別"
    @State private var message = ""
    @State private var showAlert = false
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
        }
    }
}


