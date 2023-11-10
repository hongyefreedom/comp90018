//
//  RecordDetailView.swift
//  social_media
//
//  Created by 蔡一新 on 2023/11/10.
//

import SwiftUI


struct RecordDetailView: View {
    
    var record: DetectionRecord
    var showSave : Bool
    var delta : Double
    
    @State var isNav = false
    
    init(record: DetectionRecord, showSave: Bool) {
        self.record = record
        self.showSave = showSave
        
        delta = sqrt(
            pow(record.x - record.baseX, 2) +
            pow(record.y - record.baseY, 2) +
            pow(record.z - record.baseZ, 2)
        )
    }

    
    var body: some View {
        
        
        VStack{
            ZStack {
                Image("result")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
                    
                
                VStack{
                    
                    Text("Your Result is: \(record.metal)")
                    
                    
                    Text("Magnetic Change: \(delta)")
                    
                }
            }
            
            HStack{
                
                if(!showSave){
                    Button(action: {
                        Task {
                            try await DetectionRecordModel.saveRecord(record: record)
                        }
                    }) {
                        Text("Save")
                            .font(.body)
                            .bold()
                            .foregroundColor(Color.orange1)
                            .padding()
                            .background(Color.fae)
                            .padding(.horizontal)
                        }.hidden()
                    
                    Button(action: {
                        isNav = true
                    }) {
                        Text("Publish")
                            .font(.body)
                            .bold()
                            .foregroundColor(Color.orange1)
                            .padding()
                            .background(Color.fae)
                            .padding(.horizontal)
                    }
                    
                }else {
                    Button(action: {
                        Task {
                            try await DetectionRecordModel.saveRecord(record: record)
                        }
                    }) {
                        Text("Save")
                            .font(.body)
                            .bold()
                            .foregroundColor(Color.orange1)
                            .padding()
                            .background(Color.fae)
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
                        isNav = true
                    }) {
                        Text("Publish")
                            .font(.body)
                            .bold()
                            .foregroundColor(Color.orange1)
                            .padding()
                            .background(Color.fae)
                            .padding(.horizontal)
                    }.hidden()
                    
                }
                
                
                NavigationLink("",destination: UploadPostView(record: record), isActive: $isNav
               )
                
            }
        }
        .background(Color.cream)

    }
}

//struct RecordDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordDetailView(record: DetectionRecord.MOCK_RECORDS[0])
//    }
//}
