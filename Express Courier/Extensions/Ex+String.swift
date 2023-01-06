

//  Ex+String.swift
//  Express Courier
//  Created by apple on 06/01/23.

import Foundation
import UIKit

extension String {
    func widthOfStringg(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}

