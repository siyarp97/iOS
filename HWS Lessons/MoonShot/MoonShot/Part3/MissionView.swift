//
//  MissionView.swift
//  MoonShot
//
//  Created by Şiyar Palabıyık on 26.11.2024.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember{
        let role : String
        let astronaut : Astronaut
    }
    
    let mission: Mission
    let crew : [CrewMember]
    
    init(mission: Mission, astronauts: [String : Astronaut]){
        self.mission = mission
        
        self.crew = mission.crew.map{ member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astronaut)
            }else {
                fatalError("Missin \(member.name)")
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal){ width, axis in
                        width * 0.6
                    }
                Text(mission.formattedLaunchDate)
                    .font(.subheadline)
                    .foregroundStyle(.lightBackground)
                    .padding(.top)
                VStack(alignment: .leading){
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)

                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)

                CrewView(crew: crew)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let astronauts: [String:Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
