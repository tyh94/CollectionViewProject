//
//  CasheFileManagerImage.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 27/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import Foundation

class CasheFileManagerImage {

    private let fileManager: FileManager
    private let workDirectoryName: String

    required init(fileManager: FileManager,
                  workDirectoryName: String) {
        self.fileManager = fileManager
        self.workDirectoryName = workDirectoryName
    }

    /**
     Получение рабочей директории для файлового менеджера
     - Returns: URL для рабочей директории
     */
    func workDirectory() -> String? {
        let urls = fileManager.urls(for: .documentDirectory,
                                    in: .userDomainMask)
        guard let workDirectory = urls.first?.appendingPathComponent(workDirectoryName).path else { return nil }
        if !fileManager.fileExists(atPath: workDirectory){
            try? fileManager.createDirectory(atPath: workDirectory,
                                             withIntermediateDirectories: true,
                                             attributes: nil)
        }
        return workDirectory
    }

}

// MARK: - CasheFileManager

extension CasheFileManagerImage: CasheFileManager {

    func store(data: Data, identifier: String) throws {
        guard let workDirectory = workDirectory() else {
            throw CasheFileManagerError.workDirectoryNotFound
        }
        let filename = identifier.convertToValidFileName()
        let filePath = workDirectory + "/" + filename
        if fileManager.fileExists(atPath: filePath) {
            try? fileManager.removeItem(atPath: filePath)
        }
        if !fileManager.createFile(atPath: filePath,
                                   contents: data,
                                   attributes: nil) {
            throw CasheFileManagerError.fileNotCreate
        }
    }

    func fileURL(identifier: String) throws -> URL {
        guard let workDirectory = workDirectory() else {
            throw CasheFileManagerError.workDirectoryNotFound
        }
        let filename = identifier.convertToValidFileName()
        let filePath = workDirectory + "/" + filename
        if fileManager.fileExists(atPath: filePath) {
            return URL(fileURLWithPath: filePath)
        }
        throw CasheFileManagerError.noSuchFile
    }

    func clean() throws {
        guard let workDirectory = workDirectory() else {
            throw CasheFileManagerError.workDirectoryNotFound
        }
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: workDirectory)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: workDirectory + "/" + filePath)
            }
        } catch {
            throw error
        }
    }

}

extension String {
    func convertToValidFileName() -> String {
        let invalidFileNameCharactersRegex = "[^a-zA-Z0-9_]+"
        let fullRange = startIndex..<endIndex
        let validName = replacingOccurrences(of: invalidFileNameCharactersRegex,
                                             with: "-",
                                             options: .regularExpression,
                                             range: fullRange)
        return validName
    }
}
