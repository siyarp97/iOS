//
//  ScrollViewExample.swift
//  MoonShot
//
//  Created by Şiyar Palabıyık on 24.11.2024.
//

import SwiftUI

struct ScrollViewExample: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing:10){
                ForEach(1..<100){
                    CustomText("Item \($0)", $0)
                    
                        .font(.title)
                }
             
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct CustomText : View {
    let text : String
    let item : Int
    var body: some View {
        Text(text)
    }
    
    init(_ text: String, _ item: Int) {
        print("New Custom Text! Item \(item)")
        self.text = text
        self.item = item
    }
}

#Preview {
    ScrollViewExample()
}
