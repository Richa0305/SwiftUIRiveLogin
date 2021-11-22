//
//  RiveController.swift
//  RiveLogin
//
//  Created by richa.e.srivastava on 21/11/2021.
//

import SwiftUI
import Combine
import RiveRuntime

/// Controller manages the state of the Rive animation
class RiveController: ObservableObject {
    let rive: RiveFile
    
    private let resource: String
    var fit: Fit
    var alignment: RiveRuntime.Alignment
    
    @Published var switchToFail:Bool
    @Published var switchToSuccess:Bool
    @Published var handsUp: Bool
    @Published var lookValue: Double
    @Published var username:String
    @Published var password:String

    init(
        _ resource: String,
        fit: Fit = .fitContain,
        alignment: RiveRuntime.Alignment = .alignmentCenter
    )  {
        self.fit = fit
        self.alignment = alignment
        self.resource = resource
        // TODO: fix this
        self.rive = (try? getRiveFile(resourceName: resource))!
        self.lookValue = 0.0
        self.handsUp = false
        self.switchToSuccess = false
        self.switchToFail = false
        self.username = ""
        self.password = ""
    }
    
    func verifyLogin() {
        
        
        if (self.username.lowercased() == Constants.username) && (self.password.lowercased() == Constants.password) {
            switchToSuccess = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.switchToSuccess = false
            }
        } else {
            switchToFail = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.switchToFail = false
            }
        }
    }
    
    func setLookValue(val: Double) {
        self.lookValue = val
    }
    
    
    func setHandUpState(flag: Bool) {
        self.handsUp = flag
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.handsUp = false
        }
    }

}
