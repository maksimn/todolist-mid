//
//  SimpleLogger.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 07.10.2021.
//


final class LoggerImpl: Logger {

    private let isLoggingEnabled: Bool

    init(isLoggingEnabled: Bool, category: String) {
        self.isLoggingEnabled = isLoggingEnabled
    }

    func log(_ message: String) {
        guard isLoggingEnabled else { return }

        print(message)
    }
}
