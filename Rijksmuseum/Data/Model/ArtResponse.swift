//
//  ArtResponse.swift
//  Rijksmuseum
//

//  Created by Gayan Dias on 27/06/2023.

struct ArtResponse: Codable {
    let elapsedMilliseconds: Int
    let count: Int
    let countFacets: CountFacets
    let artObjects: [Art]
    let facets: [Facets]
}

struct CountFacets: Codable {
    let hasimage: Int
    let ondisplay: Int
}

struct Art: Codable {
    let id: String
    let objectNumber: String
    let title: String
    let hasImage: Bool
    let principalOrFirstMaker: String
    let longTitle: String
    let showImage: Bool
    let permitDownload: Bool
    let webImage: WebImage?
    let headerImage: HeaderImage
    let productionPlaces: [String]
}

struct Links: Codable {
    let `self`: String
    let seb: Int
}

struct WebImage: Codable {
    let guid: String
    let url: String
}

struct HeaderImage: Codable {
    let guid: String
    let url: String
}

struct Facets: Codable {
    let facets: [Facet]
    let name: String
    let otherTerms: Int
    let prettyName: Int
}

struct Facet: Codable {
    let key: String
    let value: Int
}
