//
//  ListLayout.swift
//  MoonShot
//
//  Created by Şiyar Palabıyık on 26.11.2024.
//

import SwiftUI

struct ListLayout: View {    
    let astronauts : [String : Astronaut]
    let missions : [Mission]
    var body: some View {
        NavigationStack{
            List(missions){ mission in
                NavigationLink{
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack{
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading, spacing: 5){
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                        .padding(.leading, 5)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.lightBackground)
                    .clipShape(.rect(cornerRadius: 10))
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white.opacity(0.4))
                    }
                }
                .listRowBackground(Color.darkBackground)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .navigationTitle("Moonshot!")
        
    }
}

#Preview {
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let missions : [Mission] = Bundle.main.decode("missions.json")
    
    return ListLayout(astronauts: astronauts, missions: missions)
        .preferredColorScheme(.dark)
}
