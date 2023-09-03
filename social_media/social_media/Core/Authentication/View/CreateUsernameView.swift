//
//  CreateUsernameView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI

struct CreateUsernameView: View {
    
    //@State private var username = ""
    @EnvironmentObject var viewModel: RegistrationViewModel    
    
    var body: some View {
        VStack(spacing: 12) {

            Text("Create username")
                .font(.title2)
                .padding(.top)
                .fontWeight(.bold)
            
            Text("Pick a username for your new account. Your can always change it later")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)

            TextField("Username ", text: $viewModel.username )
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            
            NavigationLink {
                CreatePasswordView()
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

struct CreateUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUsernameView()
    }
}
