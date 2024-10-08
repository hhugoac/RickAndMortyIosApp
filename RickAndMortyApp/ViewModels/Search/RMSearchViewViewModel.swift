//
//  RMSearchViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Hector Alonzo  on 04/10/24.
//

import Foundation

// Responsabilities
// - show search results
// - show no results view
// - kick off API requests

final class RMSearchViewViewModel {
    
    let config: RMSearchViewController.Config
    private var optionMap: [RMSearchInputViewViewModel.DynamicOption: String] = [:]
    private var searchText = ""

    private var optionMapUpdateBlock: (((RMSearchInputViewViewModel.DynamicOption,String))->Void)?
    private var searchResultsHandler: ((RMSearchResultViewModel) -> Void)?
    private var noResultsHandler: (() -> Void)?
    
    private var searchResultModel: Codable?
    
    init(config: RMSearchViewController.Config) {
        self.config = config
    }
    
    // MARK: - Public
    func registerSearchResultHandler(_ block: @escaping (RMSearchResultViewModel) -> Void) {
        self.searchResultsHandler = block
    }
    
    func registerNoResultHanlder(_ block: @escaping() -> Void) {
        self.noResultsHandler = block
    }
    
    public func executeSearch() {
        
        var queryParams: [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        ]
        
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key: RMSearchInputViewViewModel.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        let request = RMRequest(endpoint: config.type.endPoint, queryParameter: queryParams)
        
        switch config.type.endPoint {
            case .character:
                makeSearchAPICall(RMGetAllCharactersResponse.self, request: request)
            case .location:
                makeSearchAPICall(RMGetAllEpisodesResponse.self, request: request)
            case .episode:
                makeSearchAPICall(RMGetAllLocationsResponse.self, request: request)
        }
        
       
    }
    
    private func makeSearchAPICall<T:Codable>(_ type: T.Type, request: RMRequest) {
        RMService.shared.execute(request, expecting: type) {
            [weak self] result in
            switch result {
                case .success(let model):
                    print("Search results in \(model)")
                    self?.processSearchResults(model: model)
                case .failure:
                    print("Failed to get results")
                    self?.handleNoResults()
                    break
            }
        }
    }
    
    func processSearchResults(model: Codable) {
        var resultsVM: RMSearchResultViewModel?
        if let characterResults = model as? RMGetAllCharactersResponse {
            resultsVM = .characters(characterResults.results.compactMap({
                return RMCharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageUrl: URL(string: $0.image)
                )
            }))
        }
        else if let episodeResults = model as? RMGetAllEpisodesResponse {
            resultsVM = .episodes(episodeResults.results.compactMap({
                return RMCharacterEpisodeCollectionViewCellViewModel(
                    episodeDataUrl: URL(string: $0.url)
                )
            }))
        }
        else if let locationResults = model as? RMGetAllLocationsResponse {
            resultsVM = .locations(locationResults.results.compactMap({
                return RMLocationTableViewCellViewModel(
                    location: $0
                )
            }))
        }
        
        if let results = resultsVM {
            self.searchResultModel = model
            self.searchResultsHandler?(results)
        } else {
            handleNoResults()
        }
        
    }
    
    private func handleNoResults() {
        noResultsHandler?()
    }
    public func set(value: String, for option: RMSearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func registerOptionChangeBlock(
    _ block: @escaping((RMSearchInputViewViewModel.DynamicOption, String) ) -> Void
    ){
        self.optionMapUpdateBlock = block
    }

    public func locationSearchResult(at index: Int) -> RMLocation? {
        guard let searchModel = searchResultModel as? RMGetAllLocationsResponse else {
            return nil
        }
        return searchModel.results[index]
    }
}
