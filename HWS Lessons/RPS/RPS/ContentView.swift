//
//  ContentView.swift
//  RPS
//
//  Created by Şiyar Palabıyık on 29.10.2024.
//

import SwiftUI

struct FrameModifier : ViewModifier{
    let bgColor : Color
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: UIScreen.main.bounds.width * 0.5, maxHeight: .infinity)
                .ignoresSafeArea()
                .background(bgColor)
    }
}

struct ContentView: View {

    let randomChoiceArr = ["Rock", "Paper", "Scissors"]

    
    let choices : [String:String] = [
        "Rock" : "✊",
        "Paper" : "✋",
        "Scissors" : "✌️"
    ]
    
    @State private var playerChoice : [String : String] = [:]
    @State private var compChoice : [String : String] = [:]
    @State private var playerChoiceText : String = ""
    @State private var randomNumber = Int.random(in: 0...2)
    @State private var randomBool = Bool.random()
    @State private var playerScore = 0
    @State private var compScore = 0
    @State private var round = 0
    
    @State private var gameEnd : Bool = false
    
    var body: some View {
        ZStack{
            
            HStack{
                // For Computer
                HStack{
                    VStack(spacing:10){
                        Spacer()
                        Text("Computer")
                        Spacer()
                        Text(choices[randomChoiceArr[randomNumber]] ?? "")
                            .font(.largeTitle)
                        Text(randomChoiceArr[randomNumber])
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text("Score : \(compScore)")
                        Spacer()
                        Spacer()
                    }
                    
                }.modifier(FrameModifier(bgColor: .red))
                
                
                //VS-Round Area
                VStack(alignment: .center){
                    Text("VS")
                        .frame(width: 30, height: 30)
                        .background(.indigo)
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                    Text("Round: \(round) / 10")
                        .padding(.top)
                        .multilineTextAlignment(.center)
                }.frame(width: 80)
                
                
                // For Player
                

                    
                VStack(spacing:10){
                    Spacer()
                    Spacer()
                    Text("Score : \(playerScore)")
                    
                    HStack{
                        ForEach(choices.sorted(by: <), id: \.key) { key, value in
                            Button {
                                round += 1
                                if randomBool == true {
                                    randomNumber = Int.random(in: 0...2)
                                } else {
                                    randomNumber = Int.random(in: 0...2)
                                }
                                playerChoice = [key : value]
                                playerChoiceText = value
                                compChoice = [randomChoiceArr[randomNumber]: choices[randomChoiceArr[randomNumber]] ?? ""]
                                randomBool.toggle()
                                playGame()
                                if round == 10 {
                                    gameEnd = true
                                }
                            } label: {
                                VStack(spacing:10){
                                    Text(value)
                                        .font(.largeTitle)
                                    Text(key)
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                }.padding(.top)
                            }
                        }
                    }
                    Spacer()
                    Text("Player")
                    Text("\(playerChoiceText)")
                    Spacer()
                }.modifier(FrameModifier(bgColor: .blue))
            }
            Spacer()

        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
        )
        .alert("Game Over", isPresented: $gameEnd) {
           Button("Restart", action: restartGame)
        } message: {
            playerScore > compScore ? Text("Winner is Player") : Text("Winner is Computer")
        }

    }
    
    func playGame(){
        if (
            (playerChoice["Rock"] != nil && compChoice["Scissors"] != nil) ||
            (playerChoice["Paper"] != nil && compChoice["Rock"] != nil) ||
            (playerChoice["Scissors"] != nil && compChoice["Paper"] != nil)
        ){
            playerScore += 1
            
        }
        else if playerChoice == compChoice {
            playerScore += 0
            compScore += 0
        }
        else{
            compScore += 1
        }
    }
    func restartGame(){
        playerScore = 0
        compScore = 0
        round = 0
        playerChoiceText = ""
    }
}

#Preview {
    ContentView()
}
