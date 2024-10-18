//
//  ContentView.swift
//  CD1_D19
//
//  Created by Şiyar Palabıyık on 18.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var chosenTemp = "Fahrenheit"
    @State private var convertedTemp = "Celsius"
    @State private var tempValue = 0.0
    
    let tempTypes = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedTempValue : Double{
        let willConvTempValue = Double(tempValue)
        var baseUnit = Measurement(value: willConvTempValue, unit: UnitTemperature.celsius)
        // Switch state
        var convertedSuper : Double = 0.0
        switch chosenTemp{
        case "Celsius":
            baseUnit =  Measurement(value: willConvTempValue, unit: UnitTemperature.celsius)
        case "Fahrenheit":
            baseUnit =  Measurement(value: willConvTempValue, unit: UnitTemperature.fahrenheit)
        case "Kelvin":
            baseUnit =  Measurement(value: willConvTempValue, unit: UnitTemperature.kelvin)
        default:
            break
        }
        
        switch convertedTemp{
        case "Celsius":
            convertedSuper = baseUnit.converted(to: UnitTemperature.celsius).value
        case "Fahrenheit":
            convertedSuper = baseUnit.converted(to: UnitTemperature.fahrenheit).value
        case "Kelvin":
            convertedSuper = baseUnit.converted(to: UnitTemperature.kelvin).value
        default:
            break
        }

        return convertedSuper
    }
    
    var body: some View {
        NavigationStack{
            
            Form{
                
                Section("CHOSEN TEMP:"){
                    Picker("Temp", selection: $chosenTemp) {
                        ForEach(tempTypes,id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("To:"){
                    Picker("To", selection: $convertedTemp) {
                        ForEach(tempTypes, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Enter Temp Value"){
                    TextField("Converted Temp", value: $tempValue, format: .number)
                }
                Section("Result"){
                    Text("\(tempValue.formatted()) \(chosenTemp) is \(Text("\(convertedTempValue, specifier: "%.2f") \(convertedTemp)").foregroundStyle(.red))")
                }
                
            }.navigationTitle("Convert It!")
        }
    }
}

#Preview {
    ContentView()
}
