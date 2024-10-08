//
//  RMSearchResultViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 07/10/24.
//

import Foundation

final class RMSearchResultViewModel {
    public private(set) var results: RMSearchResultType
    private var next: String?
    
    init(results: RMSearchResultType, next: String? = nil) {
        self.results = results
        self.next = next
        print(next)
    }
    
    public private (set) var isLoadingMoreResults = false
    
    public var shouldShowLoadMoreIndicator: Bool {
        return next != nil
    }
    
    func fetchAdditionalLocation(completion: @escaping ([RMLocationTableViewCellViewModel])->Void) {
        guard !isLoadingMoreResults else {
            return
        }
        
        guard let nextUrlString =  next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        isLoadingMoreResults = true
        
        guard let request = RMRequest(url:url) else {
            isLoadingMoreResults = false
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllLocationsResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
                case .success(let responseModel):
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.next = info.next
                    
                    let additionalLocations = moreResults.compactMap({
                        return RMLocationTableViewCellViewModel(location: $0)
                    })
                    var newResults: [RMLocationTableViewCellViewModel] = []
                    
                    switch strongSelf.results {
                        case .locations(let existingResults):
                            newResults = existingResults + additionalLocations
                            strongSelf.results = .locations(newResults)
                        case .characters, .episodes :
                            break

                    }
                    DispatchQueue.main.async {
                        strongSelf.isLoadingMoreResults = false
                        completion(newResults)
                    }
                    
                case .failure(let failure):
                    print(String(describing: failure))
                    self?.isLoadingMoreResults = false
            }
            
            
        }
    }
}

enum RMSearchResultType {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodeCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
}
