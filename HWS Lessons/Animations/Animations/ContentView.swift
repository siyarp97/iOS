//
//  ContentView.swift
//  Animations
//
//  Created by Şiyar Palabıyık on 9.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    let letters2 = Array("İrem'i Çok Seviyom")
    let letters = Array("O benim çiçeeem!")
    
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        HStack(spacing:0){
            ForEach(enabled ? 0..<letters.count : 0..<letters2.count, id:\.self){ num in
                Text(enabled ? String(letters[num]): String(letters2[num]))
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
                    .padding(2)
                    .font(.title)
                    .background(enabled ? .indigo : .mint)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
                    
            }
        }.gesture(
            DragGesture()
                .onChanged{ dragAmount = $0.translation }
                .onEnded{ _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        )
    }
}

#Preview {
    ContentView()
}
