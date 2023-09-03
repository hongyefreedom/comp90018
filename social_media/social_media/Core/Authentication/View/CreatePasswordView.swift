//
//  CreatePasswordView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI

struct CreatePasswordView: View {
    
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 12) {

            Text("Create password")
                .font(.title2)
                .padding(.top)
                .fontWeight(.bold)
            
            Text("Your password must be at least 6 characters in length")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            TextField("Password ", text: $password )
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            
            NavigationLink {
                CompleteSignupView()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 44)
                    .foregroundColor(.white)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
            
        }
    }
}

struct CreatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePasswordView()
    }
}
