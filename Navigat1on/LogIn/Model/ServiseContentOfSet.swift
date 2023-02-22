//
//  ContentOfSet.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 27.01.2023.
//

import Foundation
import UIKit

struct ServiseContentOfSet {
    enum StateKayboard {
        case Show(frameScrollView: Any, frameBottomItems: Any)
        case Hide
    }
    
    func ServiseContentOfSet(_ notification: Notification, stateKayboard: StateKayboard) -> Double {
        switch stateKayboard {
        case let .Show(frameScrollView, frameBottomItems):
            guard let frameBottomItems = (frameBottomItems as? CGRect) else {
                return 0
            }
            guard let frameScrollView = (frameScrollView as? CGRect) else {
                return 0
            }
            guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                return 0
            }
                
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            let logInButtonBottomPointY = frameBottomItems.origin.y + frameBottomItems.height
            let keyboardOriginY = frameScrollView.height - keyboardHeight
            
            let yOffset = keyboardOriginY < logInButtonBottomPointY ? logInButtonBottomPointY - keyboardOriginY + 20 : 0
    //        self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
            
            return yOffset
  
        case .Hide:
            return 0
        }
        
        
        
        
//        guard let frameBottomItems = (frameBottomItems as? CGRect) else {
//            return 0
//        }
//
//        guard let frameScrollView = (frameScrollView as? CGRect) else {
//            return 0
//        }
//
//        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
//            return 0
//        }
//
//        let keyboardHeight = keyboardFrame.cgRectValue.height
//
//        let logInButtonBottomPointY = frameBottomItems.origin.y + frameBottomItems.height
//        let keyboardOriginY = frameScrollView.height - keyboardHeight
//
//        let yOffset = keyboardOriginY < logInButtonBottomPointY ? logInButtonBottomPointY - keyboardOriginY + 20 : 0
////        self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
//
//        return yOffset
    }
    
    
}
