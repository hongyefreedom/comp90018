//
//  SwiftUIView.swift
//  social_media
//
//  Created by 蔡一新 on 2023/11/10.
//

import SwiftUI
import Kingfisher

struct DetectRecordsView: View {
    
    @State private var showAlert = false
    @StateObject var viewModel: DetectionRecordModel
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: DetectionRecordModel(user: user))
    }
   
    var body: some View {
        NavigationView  {
            LazyVStack(spacing: 20) {
                
                ForEach(viewModel.records) { record in
                    
                    NavigationLink(destination: RecordDetailView(record: record, showSave: false)
                    ) {
                        Text(record.metal)
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        Text("Mag")
                        Text("Time")
                        
                        
                        
                        
                        Spacer()
                    }
                    
                }
                
            }
        }
    }
}

//struct DetectRecordsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetectRecordsView(records: DetectionRecord.MOCK_RECORDS)
//    }
//}
