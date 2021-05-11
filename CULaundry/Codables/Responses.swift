//
//  PostResponse.swift
//  CULaundry
//
//  Created by Joshua Guo on 5/7/21.
//

struct PostResponse: Codable {
    let success: Bool
    let data: String
}

struct HallsResponse: Codable {
    let success: Bool
    let data: [LaundryRoomShort]
}

struct HallResponse: Codable {
    let success: Bool
    let data: LaundryRoomLong
}
