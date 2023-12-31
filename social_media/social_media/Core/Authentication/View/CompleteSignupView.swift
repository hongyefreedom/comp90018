//
//  CompleteSignupView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI

struct CompleteSignupView: View {
    
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 12) {

            Spacer()
            
            Text("Welcome to xxx, \(viewModel.username)")
                .font(.title2)
                .padding(.top)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("Click below to complete registeration and start using xxx")
                .font(.footnote)
                //.foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            Button {
                Task { try await viewModel.createUser()}
                //CreateUsernameView()
            } label: {
                Text("Complete Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 44)
                    .background(Color.fae)
                    .foregroundColor(Color.orange1)
                    .bold()
                    .cornerRadius(8)
            }
            .padding(.vertical)
            
            Spacer()
        }
        .background(Color.cream)
    }
}

struct CompleteSignupView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignupView()
    }
}
