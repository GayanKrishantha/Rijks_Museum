
//  Created by Gayan Dias on 28/06/2023.

import Combine

struct ArtDetail {
    let value: String
}

final class ArtDetailViewModel {
    
    private let repository: ArtRepository!
    private let coordinator: AppCoordinator!
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    let objectWithError = PassthroughSubject<String, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    var artCollectionDetail: ArtDetailResponse?
    private (set) var artDetails: [ArtDetail] = []
    var artItem: Art
    
    init(repository: ArtRepository,
         coordinator: AppCoordinator,
         artItem: Art) {
        self.repository = repository
        self.coordinator = coordinator
        self.artItem = artItem
    }
}

/// Button action / set detail values.

extension ArtDetailViewModel {
    
    func navigateBackToListView() {
        coordinator.back()
    }
    
    private func setArtDetails() {
        if let artObject = artCollectionDetail?.artObject {
            artDetails.append(ArtDetail(value: artObject.title))
            artDetails.append(ArtDetail(value: artObject.description))
            artDetails.append(ArtDetail(value: "\(L10n.firstMaker)\(artObject.principalOrFirstMaker)"))
            artDetails.append(ArtDetail(value: "\(L10n.medium)\(artObject.physicalMedium)"))
        }
    }
}

/// Network request

extension ArtDetailViewModel {
    
    func getSelectedArtDetail(objectNumber: String) async {
        await self.repository.getArtCollectionDetail(objectId: artItem.objectNumber)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    self.objectWithError.send(error.desc )
                case .finished:
                    debugPrint("Finished: ")
                }
            } receiveValue: { [self] (response) in
                processResponse(response: response)
            }
            .store(in: &subscriptions)
    }
    
    private func processResponse(response: ArtDetailResponse) {
        artCollectionDetail = response
        setArtDetails()
        objectWillChange.send()
    }
}
