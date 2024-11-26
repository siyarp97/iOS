//
//  NavigationStackExample.swift
//  MoonShot
//
//  Created by Şiyar Palabıyık on 24.11.2024.
//

import SwiftUI

struct NavigationStackExample: View {
    var body: some View {
        NavigationStack{
            List(1..<101){ row in
                NavigationLink("Go for \(row)") {
                    VStack(spacing: 20){
                        Text("Detail \(row)")
                        Image(systemName: "sailboat")
                    }
                }
            }
            .font(.title)
            .navigationTitle("I Love OP")
        }
    }
}

#Preview {
    NavigationStackExample()
}
