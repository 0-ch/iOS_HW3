//
//  BookingView.swift
//  lin_HW3
//
//  Created by User01 on 2022/11/9.
//

import SwiftUI

struct BookingView: View
{
    let places = ["南港","台北","板橋","桃園","新竹","苗栗"]
    let seatColumn = ["A","B","C","D","E"]
    @State private var placeFrom = 0
    @State private var placeTo = 5
    @State private var goDate = Date()
    @State private var isStudentOn = false
    @State private var ticketNumber = 1
    @State private var showAlert = false
    let tickeyPrice = 500
    @State var totalPrice = 0
    @State var mySeatColumn = "A"
    @State var mySeatRow = 1
    
    let time = ["7:00","9:00","11:00","13:00","15:00","17:00","20:00","23:00",]
    @State private var goTime = 0
    var body: some View
    {
        VStack
        {
            PlacePicker(places: places , placeFrom: $placeFrom, placeTo: $placeTo)
                .scaledToFill()
                .frame(width: 200, height: 50, alignment: .center)
                .scaledToFill()
            
            Group{
                DatePicker("出發日期", selection: $goDate, in: Date()..., displayedComponents: .date)
                
                HStack(alignment: .top, spacing: 90)
                {
                    Text("出發時間")
                    Picker(selection: $goTime, label:  Text("\(time[goTime])")) {
                        ForEach(0..<time.count)
                        {
                            number in
                            Text(time[number]).tag(number)
                        }
                    }.pickerStyle(MenuPickerStyle())
                }
                
                Toggle("大學生", isOn: $isStudentOn)
                
                Stepper(
                    onIncrement:
                        {
                            if(ticketNumber<10)
                            {
                                ticketNumber+=1
                            }
                        },
                    onDecrement:
                        {
                            if(ticketNumber>1)
                            {
                                ticketNumber-=1
                            }
                        },
                    label: {
                        Text("共 \(ticketNumber) 張票")
                    }
                )
            }.frame(width: 200, height: 50, alignment: .leading)
            
            Button(action:
                    {
                        showAlert = true
                        mySeatRow = Int.random(in: 1...20)
                        mySeatColumn = seatColumn.randomElement()!
                        totalPrice =  ticketNumber * tickeyPrice
                    },
                   label:
                    {
                        Text("送出訂票資訊")
                    }
            )
            .alert(isPresented: $showAlert, content: {
               
                if(isStudentOn)
                {
                    totalPrice = totalPrice * Int(0.8)
                }
                var seatString = ""
                for i in 0..<ticketNumber
                {
                    seatString += "\(mySeatRow + i) \(mySeatColumn)\n"
                }
                return Alert(title: Text("訂票成功"), message:
                                Text("總共\(totalPrice)元\n" + "座位在\n" + seatString)
                )
            })
            .foregroundColor(.red)
            .frame(width: 200, height: 50, alignment: .center)
        }
    }
}
struct BookingView_Previews: PreviewProvider
{
    static var previews: some View
    {
        BookingView()
    }
}

struct PlacePicker: View
{
    var places:[String]
    @Binding var placeFrom:Int
    @Binding var placeTo:Int
    var body: some View
    {
        HStack(alignment: .center, spacing: 40
        ){
            Picker(selection: $placeFrom, label:  Text("\(places[placeFrom])"))
            {
                ForEach(0..<places.count)
                {
                    number in
                    Text(places[number]).tag(number)
                }
            }.pickerStyle(MenuPickerStyle())
            Image(systemName: "arrow.right")
            Picker(selection: $placeTo, label:  Text("\(places[placeTo])"))
            {
                ForEach(0..<places.count)
                {
                    number in
                    Text(places[number]).tag(number)
                }
            }.pickerStyle(MenuPickerStyle())
        }
    }
}
