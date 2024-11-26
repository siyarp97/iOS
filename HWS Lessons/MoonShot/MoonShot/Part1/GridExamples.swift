//
//  GridExamples.swift
//  MoonShot
//
//  Created by Şiyar Palabıyık on 25.11.2024.
//

import SwiftUI

struct GridExamples: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120))
    ]
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout, content: {
                ForEach(1..<1000){
                    Text("Item \($0)")
                }
            })
        }
    }
}

#Preview {
    GridExamples()
}
