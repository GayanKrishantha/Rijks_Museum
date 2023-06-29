
//  Created by Gayan Dias on 27/06/2023.

struct ArtDetailResponse: Codable {
    let elapsedMilliseconds: Int
    let artObject: ArtObject
    let artObjectPage: ArtObjectPage
}

struct ArtObject: Codable {
    let id: String
    let objectNumber: String
    let title: String
    let webImage: WebImage
    let principalOrFirstMaker: String
    let description: String
    let physicalMedium: String
}

struct PrincipalMakers: Codable {
    let name: String
    let placeOfBirth: String
    let placeOfDeath: String
    let nationality: String
    let labelDesc: String
}

struct ArtObjectPage: Codable {
    let id: String
    let objectNumber: String
    let plaqueDescription: String
    let createdOn: String
    let updatedOn: String
}
