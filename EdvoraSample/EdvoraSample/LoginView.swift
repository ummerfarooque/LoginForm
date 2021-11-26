//
//  ContentView.swift
//  EdvoraSample
//
//  Created by Ummer.Manjeri on 25/11/21.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    @State private var isSecure = true
    
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            
            HStack(alignment: .center, spacing: 0){
                ZStack{
                    Image("title")
                    Image("v")
                        .padding([.bottom,.leading], -10)
                }
            }
            .padding(.top,74)
            .padding(.bottom,108)
            
            EntryFieldView(imageName: "user", placeholder: "Username", validationText: viewModel.usernamePrompt, field: $viewModel.username, strokeColorHex: "#BF9B9B")
                .padding()
            
            SecureEntryFieldView(imageName: "key", placeholder: "Password", validationText: viewModel.passwordPrompt, field: $viewModel.password, strokeColorHex: "#F0F0F0")
                .padding()
            
            EntryFieldView(imageName: "email", placeholder: "Email address", validationText: viewModel.emailPrompt, field: $viewModel.email, strokeColorHex: "#F0F0F0")
                .padding()
            
            HStack{
                Spacer()
                Button("Forgetten password?") {
                }
                .foregroundColor(Color.init(hex: "#BF9B9B"))
                .padding(.trailing,50)
            }
            .padding(.top, 25)
            .frame(height: 20)
            
            Spacer()
            
            HStack{
                
                
                Button(action: {
                    viewModel.login()
                }) {
                    HStack {
                        Spacer()
                        Text("LOGIN")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 100,height: 52)
                .contentShape(Rectangle())
                .opacity(viewModel.canSubmit ? 1 : 0.6)
                .disabled(!viewModel.canSubmit)
            }
            .background(Color.init(hex: "#733D47"))
            .cornerRadius(10)
            .padding([.leading,.trailing],36)
            
            HStack(alignment: .center, spacing: 0){
                Text("Don’t have an account?")
                    .font(.system(size: 15, weight: .regular, design: .default))
                    .foregroundColor(Color.init(hex: "#BF9B9B"))
                Button(" Sign up") {
                }
                .foregroundColor(Color.init(hex: "#BF9B9B"))
                .font(.system(size: 15, weight: .bold, design: .default))
            }
            .padding([.leading,.trailing],36)
            .padding(.top, 30)
            .frame(height: 20)
            
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            if #available(iOS 15.0, *) {
                LoginView()
                    .previewInterfaceOrientation(.landscapeLeft)
            } else {
                LoginView()
            }
            
        }
    }
}

struct EntryFieldView: View {
    var imageName: String
    var placeholder: String
    var validationText: String
    @Binding var field: String
    var strokeColorHex:String
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .center, spacing: 11) {
                Image(imageName)
                    .renderingMode(.original)
                    .padding(.leading,15)
                TextField(placeholder, text: $field)
            }
            .frame(height: 52)
            .autocapitalization(.none)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.init(hex: strokeColorHex), lineWidth: 1))
            .padding([.leading,.trailing],36)
            
            Text(validationText)
                .foregroundColor(Color.red)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
                .padding([.leading,.trailing],36)
                .padding(.bottom,4)
        }
    }
}

struct SecureEntryFieldView: View {
    var imageName: String
    var placeholder: String
    var validationText: String
    @Binding var field: String
    @State private var isSecure:Bool = true
    var strokeColorHex:String
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .center, spacing: 11) {
                Image(imageName)
                    .renderingMode(.original)
                    .padding(.leading,15)
                
                if isSecure {
                    SecureField(placeholder, text: $field)
                    
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image("eye")
                            .renderingMode(.original)
                            .padding(.trailing,15)
                    }
                    
                } else {
                    TextField(placeholder, text: $field)
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image("eye")
                            .renderingMode(.original)
                            .padding(.trailing,15)
                    }
                }
            }
            .frame(height: 52)
            .autocapitalization(.none)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.init(hex: strokeColorHex), lineWidth: 1))
            .padding([.leading,.trailing],36)
            
            Text(validationText)
                .foregroundColor(Color.red)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
                .padding([.leading,.trailing],36)
                .padding(.bottom,4)
        }
    }
}
