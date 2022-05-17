//
//  SwiftUIView.swift
//  SwiftUINetology
//
//  Created by TIS Developer on 17.05.2022.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var userName = ""
    @State private var password = ""
    
    var body: some View {
        
        VStack {
            Spacer()
            Image("logo").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            Spacer()
            
            VStack{
                TextField("Email or phone", text : $userName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                SecureField("Password", text : $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Button(action: {
                        if !userName.isEmpty && !password.isEmpty {
                            closeKeyboard()
                        }
                    }) {
                        Text("Log in")
                            .foregroundColor(.white)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)

            }
            Spacer()
        }
    }
    
    func closeKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
        )
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
