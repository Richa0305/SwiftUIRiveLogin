//
//  RiveLoginViewBridge.swift
//  RiveLogin
//
//  Created by richa.e.srivastava on 22/11/2021.
//

import SwiftUI
import RiveRuntime

struct RiveLoginViewBridge: UIViewRepresentable {
    @ObservedObject var controller: RiveController
    
    /// Constructs the view
    func makeUIView(context: Context) -> RiveView {
        do {
            let riveView = try RiveView(
                riveFile: controller.rive,
                fit: controller.fit,
                alignment: controller.alignment,
                animation: Constants.startAnimation,
                stateMachine: Constants.stateMachine
            )
                
            
            return riveView
        }
        catch{
            print(error)
            return RiveView()
        }
        
    }
    
    static func dismantleUIView(_ riveView: RiveView, coordinator: Self.Coordinator) {
        riveView.stop()
    }
    
    func updateUIView(_ riveView: RiveView, context: UIViewRepresentableContext<RiveLoginViewBridge>) {
        
        if controller.lookValue >= 1 {
            try? riveView.setBooleanState(Constants.stateMachine, inputName: Constants.checkAnimation, value: true)
            try? riveView.setNumberState(Constants.stateMachine, inputName: Constants.lookAnimation, value: Float(controller.lookValue) * 5)
        } else {
            try? riveView.setBooleanState(Constants.stateMachine, inputName: Constants.checkAnimation, value: false)
        }
        
        if controller.switchToSuccess {
            try? riveView.reset(artboard: Constants.activeArtboard, animation: Constants.startAnimation, stateMachine: Constants.stateMachine)
           try? riveView.play(animationName: Constants.successAnimation)
            
        }
        
        if controller.switchToFail {
            try? riveView.reset(artboard: Constants.activeArtboard, animation: Constants.startAnimation, stateMachine: Constants.stateMachine)
            try? riveView.play(animationName: Constants.failAnimation)
        }
        
        if controller.handsUp {
            try? riveView.setBooleanState(Constants.stateMachine, inputName: Constants.handsupAnimation, value: controller.handsUp)
        }
        
        
    }
}
