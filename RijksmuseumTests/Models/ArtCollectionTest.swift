
//  Created by Gayan Dias on 28/06/2023.

import Foundation
import XCTest

@testable import Rijksmuseum
    
class ArtCollectionTest: XCTestCase {
    
    func testArtCollectionDecodedFromJSON() throws {
        let art = try JSONDecoder().decode(ArtResponse.self, from: validProfileJSON)
        XCTAssertEqual(art.elapsedMilliseconds, 100)
        XCTAssertEqual(art.count, 777316)
        XCTAssertEqual(art.countFacets.hasimage, 594121)
        XCTAssertEqual(art.countFacets.ondisplay, 8508)
        XCTAssertEqual(art.artObjects.first?.id, "nl-SK-C-149")
        XCTAssertEqual(art.artObjects.first?.objectNumber, "SK-C-149")
        XCTAssertEqual(art.artObjects.first?.title, "Een moeder die het haar van haar kind reinigt, bekend als ‘Moedertaak")
        XCTAssertEqual(art.artObjects.first?.hasImage, true)
        XCTAssertEqual(art.artObjects.first?.principalOrFirstMaker, "Pieter de Hooch")
        XCTAssertEqual(art.artObjects.first?.longTitle, "Een moeder die het haar van haar kind reinigt")
        XCTAssertEqual(art.artObjects.first?.showImage, true)
        XCTAssertEqual(art.artObjects.first?.permitDownload, true)
        XCTAssertEqual(art.artObjects.first?.webImage?.guid, "ef64f571-6fdc-4751-a8ae-ddfcee6f8ae0")
        XCTAssertEqual(art.artObjects.first?.headerImage.guid, "acdf9034-2cca-4589-9258-2cc306de634c")
        XCTAssertEqual(art.artObjects.first?.headerImage.url, "https://lh5.ggpht.com/EHhJDrv4IB_89m9")
        XCTAssertEqual(art.artObjects.first?.productionPlaces, ["Brussel (stad)"])
    }
    
    func testArtCollectionDecodedFromMinimalJSON() throws {
        let art = try JSONDecoder().decode(ArtResponse.self, from: bareMinimum)
        XCTAssertEqual(art.elapsedMilliseconds, 100)
        XCTAssertEqual(art.count, 777316)
        XCTAssertEqual(art.countFacets.hasimage, 594121)
        XCTAssertEqual(art.countFacets.ondisplay, 8508)
        XCTAssertEqual(art.artObjects.first?.id, "nl-SK-C-149")
        XCTAssertEqual(art.artObjects.first?.objectNumber, "SK-C-149")
        XCTAssertEqual(art.artObjects.first?.title, "Tien pleurants van het praalgraf van Isabella van Bourbon")
        XCTAssertEqual(art.artObjects.first?.webImage?.guid, "ef64f571-6fdc-4751-a8ae-ddfcee6f8ae0")
        XCTAssertEqual(art.artObjects.first?.webImage?.url, "https://lh3.googleusercontent.com/6Vm9nYrTeeYe5wl")
        XCTAssertEqual(art.artObjects.first?.headerImage.guid, "acdf9034-2cca-4589-9258-2cc306de634c")
        XCTAssertEqual(art.artObjects.first?.headerImage.url, "https://lh5.ggpht.com/EHhJDrv4IB_89m9")
    }
    
    func testArtCollectionCannotCreateIfInvalidDateFormatUsedForObjectNumber() {
        let data = Data(
        """
        {
            "elapsedMilliseconds": 100,
            "count": 777316,
            "artObjects": [
                {
                    "id": "nl-SK-C-149",
                    "objectNumber": "SK-C-149",
                    "title": "Een moeder die het haar van haar kind reinigt, bekend als ‘Moedertaak’",
                    "webImage": {
                        "guid": "ef64f571-6fdc-4751-a8ae-ddfcee6f8ae0",
                        "url": "https://lh3.googleusercontent.com/6Vm9nYrTeeYe5wl7lOafEHUnbzNF8KJw3ZbV_cNBr_wQTyHyp1DJxEWEEK3OSuji9XGYx04r15HTVPu850WeFcOd0ZVv=s0"
                    },
                    "headerImage": {
                        "guid": "acdf9034-2cca-4589-9258-2cc306de634c",
                        "url": "https://lh3.googleusercontent.com/8nf3-bOz1F1aQb6zIaA1EkBNE7bntS-NzDKefrYDx0BiV05XXjhwqfHXxZhKfbDmEPfRQ1_5e242wwHsX-sjv9ec9xnF=s0"
                    },
                    "productionPlaces": []
                }
            ]
        }
        """.utf8)
        
        XCTAssertThrowsError(try JSONDecoder().decode(ArtResponse.self, from: data)) { error in
            XCTAssert(error is DecodingError)
            if let err = error as? DecodingError {
                switch (err) {
                case .typeMismatch(let type, _):
                    XCTAssert(type is Date.Type)
                default: XCTFail("Wrong error type, expected typeMismatch")
                }
            }
        }
    }
    
    func testArtCollectionCannotCreateIfInvalidDateFormatUsedForCount() {
        let data = Data(
        """
        {
            "elapsedMilliseconds": 100,
            "count": 777316,
            "artObjects": [
                {
                    "id": "nl-SK-C-149",
                    "objectNumber": "SK-C-149",
                    "title": "Een moeder die het haar van haar kind reinigt, bekend als ‘Moedertaak’",
                    "webImage": {
                        "guid": "ef64f571-6fdc-4751-a8ae-ddfcee6f8ae0",
                        "url": "https://lh3.googleusercontent.com/6Vm9nYrTeeYe5wl"
                    },
                    "headerImage": {
                        "guid": "acdf9034-2cca-4589-9258-2cc306de634c",
                        "url": "https://lh3.googleusercontent.com/8nf3-bOz1F1aQb6zIaA1EkBNE7bntS-NzDKefrYDx0BiV05XXjhwqfHXxZhKfbDmEPfRQ1_5e242wwHsX-sjv9ec9xnF=s0"
                    },
                    "productionPlaces": []
                }
            ]
        }
        """.utf8)
        
        XCTAssertThrowsError(try JSONDecoder().decode(ArtResponse.self, from: data)) { error in
            XCTAssert(error is DecodingError)
            if let err = error as? DecodingError {
                switch (err) {
                case .typeMismatch(let type, _):
                    XCTAssert(type is Date.Type)
                default: XCTFail("Wrong error type, expected typeMismatch")
                }
            }
        }
    }
}

    
extension ArtCollectionTest {
    var validProfileJSON:Data {
        Data("""
    {
        "elapsedMilliseconds": 100,
        "count": 777316,
        "countFacets": {
            "hasimage": 594121,
            "ondisplay": 8508
        },
        "artObjects": [
            {
                "links": {
                    "self": "http://www.rijksmuseum.nl/api/nl/collection/SK-C-149",
                    "web": "http://www.rijksmuseum.nl/nl/collectie/SK-C-149"
                },
                "id": "nl-SK-C-149",
                "objectNumber": "SK-C-149",
                "title": "Een moeder die het haar van haar kind reinigt, bekend als ‘Moedertaak",
                "hasImage": true,
                "principalOrFirstMaker": "Pieter de Hooch",
                "longTitle": "Een moeder die het haar van haar kind reinigt",
                "showImage": true,
                "permitDownload": true,
                "webImage": {
                    "guid": "ef64f571-6fdc-4751-a8ae-ddfcee6f8ae0",
                    "offsetPercentageX": 0,
                    "offsetPercentageY": 0,
                    "width": 6901,
                    "height": 6028,
                    "url": "https://lh3.googleusercontent.com/6Vm9nYrTeeYe5wl7lOafEHUnbzNF8KJw3ZbV_cNBr"
                },
                "headerImage": {
                    "guid": "acdf9034-2cca-4589-9258-2cc306de634c",
                    "offsetPercentageX": 0,
                    "offsetPercentageY": 0,
                    "width": 1920,
                    "height": 460,
                    "url": "https://lh5.ggpht.com/EHhJDrv4IB_89m9"
                },
                "productionPlaces": ["Brussel (stad)"]
            }
        ],
        "facets": [
            {
                "facets": [
                    {
                        "key": "Ed van der Elsken",
                        "value": 6093
                    }
                ],
                "name": "principalMaker",
                "otherTerms": 772633,
                "prettyName": 10
            }
        ]
    }
    """.utf8)
    }
    
    var bareMinimum:Data {
        Data("""
        {
            "elapsedMilliseconds": 100,
            "count": 777316,
            "countFacets": {
                "hasimage": 594121,
                "ondisplay": 8508
            },
            "artObjects": [
                {
                    "id": "nl-SK-C-149",
                    "objectNumber": "SK-C-149",
                    "title": "Een moeder die het haar van haar kind reinigt, bekend als ‘Moedertaak’",
                    "webImage": {
                        "guid": "ef64f571-6fdc-4751-a8ae-ddfcee6f8ae0",
                        "url": "https://lh3.googleusercontent.com/6Vm9nYrTeeYe5wl"
                    },
                    "headerImage": {
                        "guid": "acdf9034-2cca-4589-9258-2cc306de634c",
                        "url": "https://lh5.ggpht.com/EHhJDrv4IB_89m9"
                    },
                    "productionPlaces": ["Brussel (stad)"]
                }
            ]
        }
    """.utf8)
    }
}
