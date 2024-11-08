//
//  ContentView.swift
//  WordScramble
//
//  Created by Şiyar Palabıyık on 8.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var startWord = ""
    @State private var guessWord = ""
    @State private var wholeWords = [String]()
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showError = false
    
    var body: some View {
        NavigationStack{
            List{
                Section(){
                    TextField("Enter word", text: $guessWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                Section{
                    
                    ForEach(wholeWords, id: \.self){ word in
                        
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .onAppear(perform: startGame)
            .navigationTitle(startWord)
            .onSubmit(addNewWord)
            .alert(errorTitle, isPresented: $showError) { } message: {
                Text(errorMessage)
            }

        }
    }
    
    // FUNC 1
    func addNewWord(){
        let theWord = guessWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard theWord.count > 0 else { return }
        
        guard original(word: theWord) else{
            wordError(title: "Word is used", message: "Think Bro think..")
            return
        }
        
        guard ableToWrite(word: theWord) else {
            wordError(title: "No No No", message: "No relation with \(startWord)")
            return
        }
        
        guard checker(word: theWord) else {
            wordError(title: "Oops!", message: "No match with any word")
            return
        }
        
        withAnimation {
            wholeWords.insert(theWord, at: 0)
        }
        guessWord = ""
    }
    
    // FUNC 2
    func startGame(){
        if let bundle = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let wordList = try? String(contentsOf: bundle){
                
                let wordBox = wordList.components(separatedBy: "\n")
                startWord = wordBox.randomElement() ?? "Nonni"
                return
            }
        }
        fatalError("The 'start.txt' file couldn't find")
    }
    
    // FUNC 3
    func original(word: String) -> Bool{
        !wholeWords.contains(word)
    }
    
    // FUNC 4
    func ableToWrite(word: String) -> Bool{
        var tempWord = startWord
        
        for letter in word{
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
                print("Position : \(position)")
                print("Letter : \(letter)")
                print("tempWord : \(tempWord) ")
                print("Word : \(word)")
            }else {
                return false
            }
        }
        
        return true
    }
    
    // FUNC 5
    func checker(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return missRange.location == NSNotFound
    }
    
    // FUNC 6
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showError = true
    }
}

#Preview {
    ContentView()
}
