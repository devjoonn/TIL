//
//  LoginView.swift
//  SwiftUI_zzickmuk
//
//  Created by 박현준 on 2/29/24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isUserLoggedIn = false
    
    var isValidEmail: Bool {
        isValid(regex: "[A-ZO-9a-z. %+-1+@[A-Za-z0-9.-1+11. LA-Za-z](2,4}")
    }
    
    func login() {
        isUserLoggedIn = isValidEmail
    }
    
    private func isValid(regex: String) -> Bool {
        let text = NSPredicate(format: "SELF MATCHES %@", regex)
        return text.evaluate(with: email)
    }
}

struct LoginView1: View {
    @StateObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("로그인이 필요해요.")
                .font(.largeTitle)
                .bold()
            
            TextField("이메일을 입력해주세요.", text: $loginViewModel.email)
                .roundedTextField()
                
            
            SecureField("비밀번호를 입력해주세요.", text: $loginViewModel.password)
                .roundedTextField()
            
            Button("로그인") {
                loginViewModel.login()
            }
            .disabled(!loginViewModel.isValidEmail)
        }
        .fullScreenCover(isPresented: $loginViewModel.isUserLoggedIn) {
            Text(loginViewModel.email)
        }
    }
}

struct LoginView2: View {
    @ObservedObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            Text("로그인이 필요해요.")
                .font(.largeTitle)
                .bold()
            
            TextField("이메일을 입력해주세요.", text: $loginViewModel.email)
                .roundedTextField()
            
            
            SecureField("비밀번호를 입력해주세요.", text: $loginViewModel.password)
                .roundedTextField()
            
            Button("로그인") {
                loginViewModel.login()
            }
            .disabled(!loginViewModel.isValidEmail)
        }
        .fullScreenCover(isPresented: $loginViewModel.isUserLoggedIn) {
            Text(loginViewModel.email)
        }
    }
}

struct ContainerView: View {
    @State private var toggle: Bool = false
    
    var body: some View {
        VStack {
            Toggle("토글", isOn: $toggle)
            
            LoginView1()
            LoginView2()
        }
    }
}

extension View {
    func roundedTextField() -> some View {
        self.padding()
            .background {
                RoundedRectangle(cornerRadius: 20).stroke()
            }
            .padding([.horizontal, .bottom])
    }
}

#Preview {
    ContainerView()
}
