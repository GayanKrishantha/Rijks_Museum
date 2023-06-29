
//  Created by Gayan Dias on 28/06/2023.

import Combine

struct ArtSection {
    let header: String
    let value: [Art]
}

final class ArtListViewModel {
    
    private let repository: ArtRepository
    private let coordinator: AppCoordinator
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    let objectWithError = PassthroughSubject<String, Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private (set) var artCollection: [Art] = []
    private var perPage: Int = 5
    var sectionValue: [ArtSection] = []
    var page: Int = 0
    var totalPageCount: Int = 0
    
    init(repository: ArtRepository,
         coordinator: AppCoordinator) {
        self.repository = repository
        self.coordinator = coordinator
    }
}

/// Button action

extension ArtListViewModel {
    func navigateToDetail(artItem: Art) {
        guard !artItem.objectNumber.isEmpty else {return}
        coordinator.showDetail(artItem: artItem)
    }
}

/// Network request

extension ArtListViewModel {
    
    func getArtCollection() async {
        
        page += 1
        
        await self.repository.getArtCollections(pageCount: page,
                                                pagePageCount: perPage)
        .sink { (completion) in
            switch completion {
            case .failure(let error):
                self.objectWithError.send(error.desc )
            case .finished:
                debugPrint("Finished: ")
            }
        } receiveValue: { [self] (response) in
            procesResponse(response: response)
        }
        .store(in: &subscriptions)
    }
    
    private func procesResponse(response: ArtResponse) {
        totalPageCount = response.count
        artCollection.append(contentsOf: response.artObjects)
        filterByKeyPrincipalOrFirstMaker(items: artCollection)
        objectWillChange.send()
    }
    
    private func filterByKeyPrincipalOrFirstMaker(items: [Art]) {
        if !self.sectionValue.isEmpty {self.sectionValue.removeAll()}
        let references = Dictionary(grouping: items, by: \.principalOrFirstMaker)
        for reference in references {
            sectionValue.append(ArtSection(header: reference.key,
                                                value: reference.value))
        }
    }
}

