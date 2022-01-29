//
//  JsonCoder.swift
//  TodolistMID
//
//  Created by Maksim Ivanov on 29.01.2022.
//

import Combine
import Foundation

protocol JsonCoder {

    func convertToJson<T: Encodable>(_ object: T) -> Future<Data, Error>

    func parseFromJson<T: Decodable>(_ data: Data) -> Future<T, Error>
}
