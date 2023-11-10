//
//  RecordSevice.swift
//  social_media
//
//  Created by 蔡一新 on 2023/11/10.
//

import Foundation
import Firebase


struct RecordService {
    
    private static let recordsCollection = Firestore.firestore().collection("records")
    
    
    static func fetchUserRecords(uid: String) async throws -> [DetectionRecord] {
        let snapshot = try await recordsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: DetectionRecord.self) })
    }

}
