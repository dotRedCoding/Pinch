//
//  ControlImageView.swift
//  Pinch
//
//  Created by Jared Infantino on 2023-04-21.
//

import SwiftUI

struct ControlImageView: View {
    
    // MARK: - PROPERTY
    let icon: String
    
    // MARK: - BODY
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

// MARK: - PREVIEW
struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(icon: "minus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
