//
//  DetectionRecordModel.swift
//  social_media
//
//  Created by 蔡一新 on 2023/11/10.
//

import Foundation
import Firebase
import PhotosUI
import CoreMotion


@MainActor
class DetectionRecordModel: ObservableObject {
    
    private let user: User
    @Published var records = [DetectionRecord]()
    
    init(user: User) {
        self.user = user
        
        Task { try await fetchUserRecords() }
    }
    
    static func saveRecord(record: DetectionRecord) async throws{
        let recordRef = Firestore.firestore().collection("records").document()
        
        guard let encodedRecord = try? Firestore.Encoder().encode(record) else { return }
        try await recordRef.setData(encodedRecord)
        
    }
    
    static func createRecord(magValue: CMMagneticField, baseValue: CMMagneticField) -> DetectionRecord {
        guard let uid = Auth.auth().currentUser?.uid else {
            return  DetectionRecord(id: "", ownerUid: "", x: magValue.x, y: magValue.y, z: magValue.z, baseX: baseValue.x, baseY: baseValue.y, baseZ: baseValue.z, metal: "Fe", timestamp: Timestamp())
        }
        
        let recordRef = Firestore.firestore().collection("records").document()
        
        
        let record = DetectionRecord(id: recordRef.documentID, ownerUid: uid, x: magValue.x, y: magValue.y, z: magValue.z, baseX: baseValue.x, baseY: baseValue.y, baseZ: baseValue.z, metal: "Fe", timestamp: Timestamp())

        
        return record
        
    }
    
    
    @MainActor
    func fetchUserRecords() async throws{
        
        var fetchedRecords = try await RecordService.fetchUserRecords(uid: user.id)
        
        // Sort the fetchedPosts by timestamp in descending order
        fetchedRecords.sort { record1, record2 in
            record1.timestamp.dateValue() > record2.timestamp.dateValue()
        }
        

        self.records = fetchedRecords
        
        for i in 0..<records.count {
            records[i].user = self.user
        }
    }
    
    
}
