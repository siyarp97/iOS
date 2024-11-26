//
//  ContentView.swift
//  MoonShot
//
//  Created by Şiyar Palabıyık on 24.11.2024.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let missions : [Mission] = Bundle.main.decode("missions.json")
    

    @State private var listView = false
    
    var body: some View {

        NavigationStack{
                Group{
                    if listView{
                        ListLayout(astronauts: astronauts, missions: missions)
                    } else {
                        ScrollView {
                            GridLayout(astronauts: astronauts, missions: missions)
                        }
                    }
                }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar{
                HStack{
                    Text("Grid")
                        .foregroundStyle(listView == true ? .white : .green)
                    Toggle("", isOn: $listView)
                        .toggleStyle(SwitchToggleStyle(tint: .lightBackground))
                    Text("List")
                        .foregroundStyle(listView == true ? .green : .white)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
