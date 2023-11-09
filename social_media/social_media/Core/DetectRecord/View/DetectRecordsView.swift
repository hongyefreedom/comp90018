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
    var records: [DetectionRecord]
   
    var body: some View {
        NavigationView  {
            LazyVStack(spacing: 20) {
                
                ForEach(records) { record in
                    
                    NavigationLink(destination: RecordDetailView(record: record)
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
                        
                        Button("Publish") {
                            showAlert = true
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                            title: Text("Important message"),
                            message: Text("Please choose an option."),
                            primaryButton: .default(Text("First Option")) {
                                // Handle the first option
                            },
                            secondaryButton: .cancel(Text("Second Option")) {
                                // Handle the second option
                            }
                        )
                    }
                        
                        Spacer()
                    }
                    
                }
                
            }
        }
    }
}

struct DetectRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        DetectRecordsView(records: DetectionRecord.MOCK_RECORDS)
    }
}
