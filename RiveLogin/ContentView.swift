//
//  ContentView.swift
//  RiveLogin
//
//  Created by richa.e.srivastava on 21/11/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var riveController = RiveController(
        Constants.riveFileName
    )
    
    var body: some View {
        
        VStack {
            RiveLoginViewBridge(controller: riveController)
                .frame(width: 300, height: 300)
            VStack {
                
                ReusableText(text: "Hi There!",
                             font: .system(size: 16, weight: .semibold, design: .default))
                
                ReusableText(text: "Let's Get Started",
                             font: .system(size: 24, weight: .bold, design: .default))
                
                UserNameView(riveController: riveController,
                             userName: $riveController.username)
                
                
                PasswordView(riveController: riveController,
                             password: $riveController.password)
                
                LoginButtonView(riveController: riveController)
                
            }.padding(EdgeInsets(top: 30, leading: 20, bottom: 40, trailing: 20))
                .cornerRadius(10)
                .background(Color.black.opacity(0.2))
                .cornerRadius(20)
            
            Spacer()
            
            LoginWithFG()
            
        }.padding(20)
            .background(LinearGradient(colors: [Color(hex: "9D92DF"), Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
            .ignoresSafeArea()
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ReusableText: View {
    var text: String
    var font: Font
    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(.white)
            .padding(.zero)
    }
}

struct UserNameView: View {
    var riveController: RiveController
    @Binding var userName: String
    var body: some View {
        TextField("Username", text: $userName, onEditingChanged: { status in
            print("onEditingChanged called \(riveController.username)")
            riveController.setLookValue(val: 0.0)
        })
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(30.0)
            .frame(width: 350, height: 50)
            .padding(.bottom ,5)
            .onChange(of: riveController.username) { newValue in
                print("onChange called \(newValue)")
                riveController.setLookValue(val: Double(newValue.count))
            }
    }
}


struct PasswordView: View {
    var riveController: RiveController
    @Binding var password: String
    var body: some View {
        SecureField("Password", text: $password).padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(30.0)
            .frame(width: 350, height: 50)
            .padding(.bottom ,8)
            .onChange(of: riveController.password) { newValue in
                riveController.setHandUpState(flag: true)
            }
    }
    
}

struct LoginButtonView: View {
    var riveController: RiveController
    var body : some View {
        Button{
            riveController.verifyLogin()
        } label: {
            Text("LOGIN")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 350, height: 50)
                .background(LinearGradient(colors: [Color(hex: "A02D62"), Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(30.0)
        }
        .shadow(color: Color.black.opacity(0.7), radius: 2, x: 2, y: 2)
    }
}

struct LoginWithFG : View {
    var body : some View {
        VStack {
            Text("------------- Or Login With -------------")
                .font(.headline)
                .foregroundColor(.white.opacity(0.5))
                .padding(.zero)
            
            HStack(spacing: 30) {
                Image("facebook")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .shadow(color: Color.black.opacity(0.7), radius: 2, x: 2, y: 2)
                Image("google")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .shadow(color: Color.black.opacity(0.7), radius: 2, x: 2, y: 2)
            }
        }.padding(.bottom, 30)
    }
}
