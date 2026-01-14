//
//  Astronaut.swift
//  MoonShot
//
//  Created by Christian on 10/29/25.
//

struct Astronaut: Codable, Identifiable {
    // Codable so that we can load the JSON into instances of this struct
    // Identifiable so that we can make it into an array we can work with for lists/ForEaches
    
    let id: String
    let name: String
    let description: String
    
    var image: String {
        "\(id)"
    }
        
}
