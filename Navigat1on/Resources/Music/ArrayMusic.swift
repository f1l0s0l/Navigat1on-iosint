//
//  arra.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 14.02.2023.
//

import UIKit

struct Music {
    var url: URL
    var nameArtist: String
    var nameSong: String
    var labelPhoto: UIImage?
    var id: String
    var time: String
}

final class ArrayMusic {
    static var shared = ArrayMusic()
    
//    var formatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "mm:ss"
//        return formatter
//    }()
    
    
    var arrayMusic: [Music] = [
        Music(
            url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Queen", ofType: "mp3")!),
            nameArtist: "Queen",
            nameSong: "Какая то песня",
            labelPhoto: UIImage(named: "Queen"),
            id: UUID().uuidString,
            time: "04:03"
        ),
        Music(
            url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "09. Decibel", ofType: "mp3")!),
            nameArtist: "AC/DC",
            nameSong: "Decibel",
            labelPhoto: UIImage(named: "ACDC"),
            id: UUID().uuidString,
            time: "03:33"
        ),
        Music(
            url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "10. Stormy May Day", ofType: "mp3")!),
            nameArtist: "AC/DC",
            nameSong: "Stormy May Day",
            labelPhoto: UIImage(named: "ACDC"),
            id: UUID().uuidString,
            time: "03:10"
        ),
        Music(
            url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Dalabil - звезда", ofType: "mp3")!),
            nameArtist: "Dalabil",
            nameSong: "Звезда",
            labelPhoto: UIImage(named: "1"),
            id: UUID().uuidString,
            time: "01:32"
        ),
    ]
    
}
