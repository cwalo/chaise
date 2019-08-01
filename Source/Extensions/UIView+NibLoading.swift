//
//  UIView+NibLoading.swift
//  chaise
//
//  Created by Corey Walo on 7/31/19.
//  Copyright © 2019 Corey Walo. All rights reserved.
//

import UIKit

protocol NibLoading {
    static var nibName: String { get }
}

extension NibLoading where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }

    static func instantiate() -> Self {
        guard let nibs = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil) else {
            fatalError("Nib does not exist for \(nibName)")
        }
        return nibs.first as! Self
    }
}
