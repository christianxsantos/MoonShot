//
//  Bundle-Decoder.swift
//  MoonShot
//
//  Created by Christian on 10/29/25.
//

import Foundation


extension Bundle {
    
    func decode<T : Codable>(_ file: String) -> T {
        
        guard let url = url(forResource: file, withExtension:"json") else {
            fatalError("Couldn't find \(file)")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Couldn't load contents from \(file).")
        }
        
        let decoder = JSONDecoder()
        
        guard let result: T = try? decoder.decode(T.self, from: data) else {
            fatalError("Couldn't decode contents of data \(file).")
        }
        
        return result
    }

}
