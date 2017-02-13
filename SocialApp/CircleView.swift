//
//  CircleView.swift
//  SocialApp
//
//  Created by Anze Vavken on 12/02/2017.
//  Copyright © 2017 VavkenApps. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
        
    }

}
