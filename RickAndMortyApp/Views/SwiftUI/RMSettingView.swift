//
//  RMSettingView.swift
//  RickAndMortyApp
//
//  Created by Hugo Alonzo on 01/10/24.
//

import SwiftUI

struct RMSettingView: View {
    
    let viewModel: RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewModels) {
            viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(8)
                        .background(Color(viewModel.iconContainerColor))
                        .cornerRadius(6)
                }
                
                Text(viewModel.title)
                    .padding(.leading, 10)
            }
            .padding(.bottom, 3)
        }
    }
}

#Preview {
    RMSettingView(viewModel: .init(cellViewModels: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellViewModel(type: $0)
        })
    ))
}
