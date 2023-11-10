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
    
    @State var isNav = false
    
    var body: some View {
        
        
        VStack{
            ZStack {
                Image("result")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
                    
                
                VStack{
                    
                    Text("Your Result is: \(record.metal)")
                    
                    
                    Text("Magnetic before Detect: \((record.x + record.y + record.z))")
                    Text("Magnetic after Detect: \((record.baseX + record.baseY + record.baseZ))")
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
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }.hidden()
                }else {
                    Button(action: {
                        Task {
                            try await DetectionRecordModel.saveRecord(record: record)
                        }
                    }) {
                        Text("Save")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                
                Button(action: {
                    isNav = true
                }) {
                    Text("Publish")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                NavigationLink("",destination: UploadPostView(record: record), isActive: $isNav
               )
                
            }
        }

    }
}

//struct RecordDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordDetailView(record: DetectionRecord.MOCK_RECORDS[0])
//    }
//}
