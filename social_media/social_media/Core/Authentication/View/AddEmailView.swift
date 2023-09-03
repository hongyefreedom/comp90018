//
//  AddEmailView.swift
//  social_media
//
//  Created by 安泓晔 on 30/8/2023.
//

import SwiftUI

struct AddEmailView: View {
    
    //@State private var email = ""
    // 点它就关闭
    //@Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: RegistrationViewModel    
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 12) {

                Text("Add your email")
                    .font(.title2)
                    .padding(.top)
                    .fontWeight(.bold)
                
                Text("You'll use this email to sign in to your account.")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .modifier(IGTextFieldModifier())
                    .padding(.top)
                
                NavigationLink {
                    CreateUsernameView()
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
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Image(systemName: "chevron.left")
//                        .imageScale(.large)
//                        .onTapGesture {
//                            dismiss()
//                        }
//                }
//            }
        }
    }
}

struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmailView()
    }
}
