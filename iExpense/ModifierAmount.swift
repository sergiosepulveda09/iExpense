//
//  ModifierAmount.swift
//  iExpense
//
//  Created by Sergio Sepulveda on 2021-07-06.
//
import SwiftUI
import Foundation

extension Text {
    func customText(value: Int) -> some View  {
        if value < 10 {
            return self
                .fontWeight(.regular)
                .foregroundColor(.yellow)
        } else if value < 100 {
            return self
                .fontWeight(.black)
                .foregroundColor(.orange)
        } else {
            return self
                .fontWeight(.heavy)
                .foregroundColor(.red)
        }

    }
}


