//
//  CustomError.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import Foundation

enum CustomError: String, Error {
    case unknownError = "Unknown error"
    case authError = "Auth error"
    case imageCompressionError = "Image compression error"
    case imageUploadError = "Image upload error"
    case historyPostError = "History post error"
    case progressPostError = "Progress post error"
    case extraFinishError = "Extra finish error"
}
