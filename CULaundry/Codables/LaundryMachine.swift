//
//  LaundryMachine.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/5/21.
//

struct LaundryMachine: Codable {
    let machine_name: String
    let isWasher: Bool
    let isAvailable: Bool
    let isOOS: Bool
    let timeLeft: Int
}
