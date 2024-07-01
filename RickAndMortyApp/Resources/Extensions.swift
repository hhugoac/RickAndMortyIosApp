//
//  Extensions.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 29/06/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
