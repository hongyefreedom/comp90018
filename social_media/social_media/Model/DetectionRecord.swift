//
//  DetectionRecord.swift
//  social_media
//
//  Created by 蔡一新 on 2023/11/7.
//

import Foundation
import Firebase

struct DetectionRecord: Identifiable, Hashable, Codable{
    let id: String
    let ownerUid: String
    let imageUrl: String
    let x: Double
    let y: Double
    let z: Double
    let metal: String
    let timestamp: Timestamp
    
}

extension DetectionRecord {
    static var MOCK_RECORDS: [DetectionRecord] = [
            .init(
                id: NSUUID().uuidString,
                ownerUid: NSUUID().uuidString,
                imageUrl: "head",
                x: 1,
                y: 2,
                z: 3,
                metal: "Au",
                timestamp: Timestamp()
            ),
        
            .init(
                id: NSUUID().uuidString,
                ownerUid: NSUUID().uuidString,
                imageUrl: "head1",
                x: 1,
                y: 2,
                z: 3,
                metal: "Fe",
                timestamp: Timestamp()
            ),
        
            .init(
                id: NSUUID().uuidString,
                ownerUid: NSUUID().uuidString,
                imageUrl: "head2",
                x: 1,
                y: 2,
                z: 3,
                metal: "Ti",
                timestamp: Timestamp()
            )
    ]
}
