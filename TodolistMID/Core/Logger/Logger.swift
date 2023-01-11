//
//  Logger.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 07.10.2021.
//

import os

protocol Logger {

    func log(_ message: String, _ level: OSLogType)
}
