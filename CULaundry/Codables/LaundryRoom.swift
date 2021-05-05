//
//  LaundryRoom.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/5/21.
//

struct LaundryRoomShort: Codable {
    let name: String
    let num_avail_wash: Int
    let num_avail_dry: Int
}

struct LaundryRoomLong: Codable {
    let name: String
    let machines: [LaundryMachine]
}
