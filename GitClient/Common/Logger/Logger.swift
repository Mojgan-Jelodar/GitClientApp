//
//  Logger.swift
//  GitClient
//
//  Created by Mozhgan on 9/23/21.
//

import Foundation
public protocol Logger {
    func trace(request: URLRequest, session: URLSession)
    func trace(response: HTTPURLResponse, data: Data?)
    func trace(url: URL, source: String?)
    func trace(request: URLRequest?, error: Error)

}

protocol LoggerOutput {
    func log(message: String)
    func newLine()
}

struct DefaultOutput: LoggerOutput {
    func log(message: String) { print(message) }
    func newLine() { print() }
}

struct DefaultLogger: Logger {

    let output: LoggerOutput

    init(output: LoggerOutput = DefaultOutput()) {
        self.output = output
    }

    func trace(request: URLRequest, session: URLSession) {
        guard
            let method = request.httpMethod,
            let url = request.url?.absoluteString
            else { return }
        output.log(message: "\(method) \(url) HTTP/1.1")
        session.configuration.httpAdditionalHeaders?.forEach { key, value in output.log(message: "\(key): \(value)") }
        request.allHTTPHeaderFields?.forEach { key, value in output.log(message: "\(key): \(value)") }
        if let data = request.httpBody, let string = String(data: data, encoding: .utf8) {
            output.newLine()
            output.log(message: string)
        }
        output.newLine()
    }

    func trace(response: HTTPURLResponse, data: Data?) {
        output.log(message: "HTTP/1.1 \(response.statusCode)")
        response.allHeaderFields.forEach { key, value in output.log(message: "\(key): \(value)") }
        if let data = data, let string = String(data: data, encoding: .utf8) {
            output.newLine()
            output.log(message: string)
        }
        output.newLine()
    }

    func trace(url: URL, source: String?) {
        output.log(message: "\(source ?? "URL"): \(url.absoluteString)")
    }

    func trace(request: URLRequest?, error: Error) {
        guard
            let method = request?.httpMethod,
            let url = request?.url?.absoluteString
            else { return }
        output.log(message: "\(method) \(url) HTTP/1.1")
        request?.allHTTPHeaderFields?.forEach { key, value in output.log(message: "\(key): \(value)") }
        output.newLine()
        output.log(message: error.localizedDescription)
        output.newLine()
    }
}
