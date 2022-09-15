//
//  CustomGroupBoxStyle.swift
//  Spenny
//
//  Created by Greg Ross on 15/09/2022.
//

import Foundation


struct ColoredGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding()
            .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.groupBoxBackgroundColor)) // Set your color here!!
    }
}
