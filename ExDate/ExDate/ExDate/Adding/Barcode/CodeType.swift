//
//  CodeType.swift
//  ExDate
//
//  Created by Zhasmin Mirzoeva on 16/04/24.
//


import AVFoundation
enum CodeType {
    case ean8
    case ean13
    case dataMatrix
    var rawValue: AVMetadataObject.ObjectType {
        switch self {
            case .ean8:
                return AVMetadataObject.ObjectType.ean8
            case .ean13:
                return AVMetadataObject.ObjectType.ean13
        case .dataMatrix:
            return AVMetadataObject.ObjectType.dataMatrix
        }
    }
}
