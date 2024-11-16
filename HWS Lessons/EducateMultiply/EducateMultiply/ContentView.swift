//
//  ContentView.swift
//  EducateMultiply
//
//  Created by Şiyar Palabıyık on 11.11.2024.
//

import SwiftUI

struct GetResultPage : View{
    var firstNum : Int
    var secondNums : [Int]
    var results : [Int]
    
    var body: some View {
        List {
            ForEach(Array(secondNums.enumerated()), id: \.offset){ index, num in
                HStack(spacing: 0){
                    Text("\(firstNum) x \(num) = " )
                    Text("\(firstNum * num) / ")
                        .foregroundStyle(results[index] == (firstNum * num) ? .green : .red)
                    Text("\(results[index])")
                }
            }
        }
    }
}



struct ContentView: View {
    
    @State private var selectedNum = 2
    @State private var selectedDiffuculty = "Easy"
    let diffucultyLevels = ["Easy", "Medium", "Hard"]
    let diffucultyValues : [String : Int] = ["Easy" : 5, "Medium" : 10, "Hard" : 20]
    @State private var askingNumbers = [Int]()
    @State private var answerNum : Int?
    @State private var answerNumArr = [Int]()
    @State private var nextQuestionIndex = 0
    @State private var startTraining = false
    @State private var getResults = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack{
            List{
                Section("Choose Settngs"){
                    VStack(spacing: 15){
                        Stepper(value: $selectedNum, in: 2...12) {
                            HStack{
                                Text("Training Num :")
                                Text("\(selectedNum)")
                            }
                        }.padding(.horizontal)
                        
                        Picker("Select Diffuculty Level", selection: $selectedDiffuculty) {
                            ForEach(diffucultyLevels, id: \.self) { Text($0) }
                            
                        }.pickerStyle(.segmented)
                        Button(startTraining == false ? "Start Game" : "End Game"){
                            startTrainingFunc()
                        }
                    }
                    
                }
                
                Section("Multiply Table"){
                    if startTraining == true{
                            VStack{
                                HStack{
                                    Text("\(selectedNum) x \(askingNumbers[nextQuestionIndex]) =")
                                    TextField("Enter", value: $answerNum, format: .number)
                                        .keyboardType(.asciiCapableNumberPad)
                                        .textFieldStyle(.roundedBorder)
                                }
                                Button((askingNumbers.endIndex == nextQuestionIndex + 1) ? "Get Results" : "Next"){
                                    nextQuestion()
                                }
                            }.transition(.slide)
                    }
                }
            }.navigationTitle("Multiply Me! ").navigationBarTitleDisplayMode(.inline)
                .scrollContentBackground(.hidden)
                .background(LinearGradient(colors: [.yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
        }.alert(alertTitle,
                isPresented: $showAlert){
            Button("OK"){ }
        } message: {
            Text(alertMessage)
        }
        .onChange(of: startTraining) { startTraining == false ? askingNumbers.removeAll() : nil }
        .onChange(of: selectedNum,{
            endGame()
        })
        .onChange(of: selectedDiffuculty, {
            endGame()
        })
        .onSubmit() {
            nextQuestion()
        }
        .sheet(isPresented: $getResults,
               onDismiss: endGame,
               content: {
            GetResultPage(firstNum: selectedNum, secondNums: askingNumbers, results: answerNumArr)
        })
    }
    
    func startTrainingFunc(){
        startTraining.toggle()
        if startTraining == true {
            for _ in 1...(diffucultyValues[selectedDiffuculty] ?? 5){
                let randomNumber = Int.random(in: 2...12)
                askingNumbers.insert(randomNumber, at: 0)
            }
        }else {
            endGame()
        }
    }
    
    func nextQuestion(){
        guard (answerNum != nil) else {
            theAlert(title: "Enter A Num", message: "Please Enter A Value")
            return
        }
        answerNumArr.append(answerNum ?? 0)
        if nextQuestionIndex >= askingNumbers.count - 1{
            getResults = true
        } else{
            nextQuestionIndex += 1
        }
        answerNum = nil
    }
    
    func endGame(){
        askingNumbers.removeAll()
        answerNumArr.removeAll()
        answerNum = nil
        nextQuestionIndex = 0
        startTraining = false
    }

    func theAlert(title: String, message: String){
        showAlert = true
        alertTitle = title
        alertMessage = message
    }
}
#Preview {
    ContentView()
}


