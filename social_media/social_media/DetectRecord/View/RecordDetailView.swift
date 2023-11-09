//
//  RecordDetailView.swift
//  social_media
//
//  Created by 蔡一新 on 2023/11/10.
//

import SwiftUI


struct RecordDetailView: View {
    
    var record: DetectionRecord
    
    var body: some View {
        
        VStack{
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 200, height: 300)
                    .border(Color.black, width: 2)
                    
                
                VStack{
                    Text("\(record.x)")
                    Text("\(record.y)")
                    Text("\(record.z)")
                    Text(record.metal)
                }
            }
            
            HStack{
                Button(action: {
                    
                }) {
                    Text("Save")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }.hidden()
                
                Button(action: {
                    
                }) {
                    Text("Publish")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }

    }
}

struct RecordDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetailView(record: DetectionRecord.MOCK_RECORDS[0])
    }
}
