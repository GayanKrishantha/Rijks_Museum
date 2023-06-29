
//  Created by Gayan Dias on 28/06/2023.


import UIKit

extension ArtListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionValue.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let items = viewModel.sectionValue[section].value
        let item = items.count
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: artListIdentifire,
                                                      for: indexPath) as! ArtListCell
        let item: ArtSection  = viewModel.sectionValue[indexPath.section]
        cell.setValues(art: item.value[indexPath.row])
        
        return cell
    }
}
