//
//  roundButton.swift
//  SocialApp
//
//  Created by Anze Vavken on 11/02/2017.
//  Copyright © 2017 VavkenApps. All rights reserved.
//

import UIKit

class roundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(displayP3Red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 1.0).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageView?.contentMode = .scaleAspectFit
    }
    
    override func layoutSubviews() { //Če računaš more bit v layout subviews, drugače kot pri FancyButton
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.height / 2
        
    }
}
