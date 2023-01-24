//
//  CustomButton.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 24.01.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    // MARK: - Properties

    var target: (() -> Void)?
    
    
    // MARK: - Life Cycle
    
    init(title: String? = nil,
         titleColor: UIColor? = nil,
         backgroundColor: UIColor? = nil,
         backgroundImage: UIImage? = nil,
         backgroundImageState_Selected_Highlighted_Disabled: UIImage? = nil
    ) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.setBackgroundImage(backgroundImageState_Selected_Highlighted_Disabled, for: .selected)
        self.setBackgroundImage(backgroundImageState_Selected_Highlighted_Disabled, for: .highlighted)
        self.setBackgroundImage(backgroundImageState_Selected_Highlighted_Disabled, for: .disabled)
        
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addTarget(self, action: #selector(didPabButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func didPabButton() {
        target?()
    }
    
}
