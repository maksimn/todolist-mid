//
//  JsonCoderImpl.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 29.01.2022.
//

import Combine
import Foundation

final class JsonCoderImpl: JsonCoder {

    func convertToJson<T: Encodable>(_ object: T) -> Future<Data, Error> {
        Future { promise in
            do {
                let data = try JSONEncoder().encode(object)

                promise(.success(data))
            } catch {
                promise(.failure(error))
            }
        }
    }

    func parseFromJson<T: Decodable>(_ data: Data) -> Future<T, Error> {
        Future { promise in
            do {
                let typedObject = try JSONDecoder().decode(T.self, from: data)

                promise(.success(typedObject))
            } catch {
                promise(.failure(error))
            }
        }
    }
}
