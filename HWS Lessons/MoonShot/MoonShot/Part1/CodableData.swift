//
//  CodableData.swift
//  MoonShot
//
//  Created by Şiyar Palabıyık on 25.11.2024.
//

import SwiftUI

struct CodableData: View {
    var body: some View {
        Button("Decode JSON"){
            let input = """
            {
                "name": "Monkey D. Luffy",
                "address": {
                    "street": "168.Str Bıca",
                    "city": "İzmir"
                }
            }
            """
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data){
                print(user.name)
            }
        }
    }
}

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

#Preview {
    CodableData()
}
