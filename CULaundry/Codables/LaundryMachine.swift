//
//  LaundryMachine.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/5/21.
//

struct LaundryMachine: Codable {
    let machine_name: String
    let isWasher: Int
    let isAvailable: Int
    let isOOS: Int
    let isOffline: Int
    let timeLeft: Int
}
