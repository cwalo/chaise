//
//  JSONFileStoring.swift
//  chaise
//
//  Created by Corey Walo on 8/1/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import Foundation

protocol JSONFileStoring {
    func write<T: Codable>(data: T, to fileNamed: String) throws
    func get<T: Codable>(type: T.Type, from fileNamed: String) throws -> T
}

extension JSONFileStoring {
    func write<T: Codable>(data: T, to fileNamed: String) throws {
        let libraryDirectory = try FileManager.default.url(for: .libraryDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: true)

        let path = libraryDirectory.appendingPathComponent("\(fileNamed).json")

        createFileIfNeeded(at: path.absoluteString)

        let json = try JSONEncoder().encode(data)
        try json.write(to: path)
    }

    func get<T: Codable>(type: T.Type, from fileNamed: String) throws -> T {
        let libraryDirectory = try FileManager.default.url(for: .libraryDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: true)

        let path = libraryDirectory.appendingPathComponent("\(fileNamed).json")
        let json = try Data(contentsOf: path)
        return try JSONDecoder().decode(T.self, from: json)
    }

    func createFileIfNeeded(at path: String) {
        guard !FileManager.default.fileExists(atPath: path) else { return }
        FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
    }
}
