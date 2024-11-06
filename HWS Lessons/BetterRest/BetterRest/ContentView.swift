//
//  ContentView.swift
//  BetterRest
//
//  Created by Şiyar Palabıyık on 1.11.2024.
//

import CoreML
import SwiftUI


struct ContentView: View {
    
    static var defaultWakeTime : Date {
        var components = DateComponents()
        components.hour = 6
        components.minute = 30
        return  Calendar.current.date(from: components) ?? .now
    }
    
    
    
    @State private var sleepTime = 8.0
    @State private var cupsOfCoffee = 1
    @State private var wakeUp = defaultWakeTime
    @State private var errorShow = false
    
    var calculateView : String{
        
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepTime, coffee: Double(cupsOfCoffee))
            
            let bedTime = wakeUp - prediction.actualSleep
            let bedTimeAsStr = bedTime.formatted(date: .omitted, time: .shortened)
            
            return "\(bedTimeAsStr)"
        } catch{
            errorShow = true
            return "Oops.. We Couldn't Reach It!"
        }
    }
    
    @ViewBuilder var calculateShow : some View{
        VStack{
            VStack{
                Text("Your Bed Time is")
                    .opacity(errorShow == true ? 0 : 1)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
                    
                Text(calculateView)
                    .font(.headline)
                    .foregroundStyle(.black)
            }.padding(.vertical)
        }.frame(maxWidth: .infinity)
            .background(.ultraThickMaterial)
            .cornerRadius(10)
            
    }
    
    var body: some View {
        NavigationStack{
            Form{
                
                Section("Tell your wake up time") {
                    DatePicker("Enter your wake up", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .frame(maxWidth: .infinity)
                        .padding(.trailing)
                        .padding(.vertical, 1)
                }
                
                Section("How many hours do you sleep?") {
                    Stepper("\(sleepTime.formatted())", value: $sleepTime, in: 4...12, step: 0.25)
                }
                
                Section("How many coffee do you drink in a day?") {
                    Picker("^[\(cupsOfCoffee) cup](inflect: true)", selection: $cupsOfCoffee) {
                        ForEach(1...20, id: \.self){ number in
                            Text("\(number)")
                        }
                    }.pickerStyle(MenuPickerStyle())
                }
                
                Section {
                    VStack{
                        Text("The Result")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.indigo)
                        calculateShow
                    }
                }
            }
            .navigationTitle("Better Rest")
        }
    }
}

#Preview {
    ContentView()
}
