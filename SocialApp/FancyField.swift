//
//  FancyField.swift
//  SocialApp
//
//  Created by Anze Vavken on 11/02/2017.
//  Copyright © 2017 VavkenApps. All rights reserved.
//

import UIKit

class FancyField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(displayP3Red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.5).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
    
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

}
