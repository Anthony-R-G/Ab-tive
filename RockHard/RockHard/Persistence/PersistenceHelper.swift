//
//  PersistenceHelper.swift
//  GhibliPractice
//
//  Created by C4Q on 10/2/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import Foundation
struct PersistenceHelper<T: Codable> {
    func getObjects() throws -> [T] {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    func save(newElement: T) throws {
        var elements = try getObjects()
        elements.append(newElement)
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    func delete(num: Int) throws{
        var elements = try getObjects()
        elements.remove(at: num)
           let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    func edit(num: Int, newElement: T) throws{
        var elements = try getObjects()
        elements[num] = newElement
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    init(fileName: String){
        self.fileName = fileName
    }
    
    private let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    private func filePathFromDocumentsDirectory(name: String) -> URL {
        return documentsDirectory.appendingPathComponent(name)
    }
    
    private let fileName: String
    
    private var url: URL {
        return filePathFromDocumentsDirectory(name: fileName)
    }
}
