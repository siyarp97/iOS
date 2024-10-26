//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Şiyar Palabıyık on 18.10.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var gameEnd = false
    @State private var gameRound = 1
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red:0.3, green: 0.3, blue: 0.50), location: 0.3),
                .init(color: Color(red:0.22, green:0.1, blue:0.3), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack{
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing:30){
                    VStack {
                        Text("Guess the flag")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.semibold))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.heavy))
                    }
                    ForEach(0..<3){ number in
                        Button{
                            tappedFlag(number)
                        }label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 10)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)/8")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Text("Round : \(gameRound)")
                    .font(.subheadline.weight(.regular))
                    .foregroundStyle(.white)
                    .opacity(gameEnd == true ? 0 : 1)
                Spacer()
                
            }.padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: question)
        }message: {
            Text("Your score is \(score)/8")
        }
        .alert("Game End!", isPresented: $gameEnd) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your score is \(score)/8")
        }

    }
    func tappedFlag(_ number : Int){
        if number == correctAnswer{
            score += 1
            scoreTitle = "Correct!"
        }
        else{
            scoreTitle = "False! That's the flag of \(countries[number])"
        }
        gameRound += 1
        if gameRound == 9 {
            endOfTheGame()
        }else{
            showingScore = true
        }
    }
    func question(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func endOfTheGame(){
        showingScore = false
        gameEnd = true
    }
    func resetGame(){
        gameRound = 1
        score = 0
        gameEnd = false
        question()
    }
}

#Preview {
    ContentView()
}
