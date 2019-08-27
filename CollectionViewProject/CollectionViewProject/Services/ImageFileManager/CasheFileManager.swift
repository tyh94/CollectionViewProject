//
//  CasheFileManager.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 27/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import Foundation

enum CasheFileManagerError: Error {
    case workDirectoryNotFound
    case noSuchFile
    case fileNotCreate
}

/**
 Протокол для работы с файлами
 */
protocol CasheFileManager {

    /**
     Сохранить данные, удалить если такая уже есть
     - Parameter data: данные для сохранения
     - Parameter identifier: Идентификатор
     */
    func store(data: Data,
               identifier: String) throws

    /**
     Получить урл данных
     - Parameter identifier: Идентификатор данных
     - Returns: урл данных
     */
    func fileURL(identifier: String) throws -> URL

    /**
     Очистить папку
     */
    func clean() throws

}
