//
//  PlayListModel.swift
//  songify
//
//  Created by yury mid on 31.10.2022.
//

import Foundation

struct Song: Hashable {
    let image: Int
    let name: String
    let author: String
    let fileName: String
}

let playList: [Song] = [
    Song(image: 0, name: "Voyager", author: "Jasper Byrne", fileName: "Jasper Byrne - Voyager.mp3"),
    Song(image: 12, name: "Given to fly", author: "Pearl Jam", fileName: "Pearl Jam - Given to fly.mp3"),
    Song(image: 0, name: "The Getting by II", author: "The Killers", fileName: "The Killers - The Getting by II.mp3"),
    Song(image: 0, name: "Angel of the Morning", author: "Juice Newton", fileName: "audioTest.m4a"),
    Song(image: 16, name: "I Really Want to Stay at Your House", author: "Rosa Walton & Hallie Coggins", fileName: "Rosa Walton Hallie Coggins - I Really Want to Stay at Your House.mp3"),
    Song(image: 0, name: "Baby Im Yours", author: "Breakbot Irfane", fileName: "Breakbot Irfane - Baby Im Yours.mp3"),
    Song(image: 0, name: "Son Of A Preacher Man", author: "Dusty Springfield", fileName: "Dusty Springfield - .mp3"),
    Song(image: 0, name: "Putting a spin on heather", author: "The Egg", fileName: "Egg - putting a spin on heather.mp3"),
    Song(image: 0, name: "To Make Time", author: "Rafo Herro", fileName: "Rafo Herro - To Make Time.mp3"),
    Song(image: 17, name: "Who's Ready for Tomorrow", author: "Rat Boy & IBDY", fileName: "Rat Boy IBDY - Whos Ready for Tomorrow.mp3"),
    Song(image: 0, name: "Love Being Used", author: "tg.blk", fileName: "tg.blk - Love Being Used.mp3"),
]
