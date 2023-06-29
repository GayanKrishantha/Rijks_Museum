
//  Created by Gayan Dias on 28/06/2023.


import UIKit
import SnapKit
import MBProgressHUD
import Combine

class ArtListViewController: UIViewController {
    
    /// Instance
    
    var viewModel: ArtListViewModel!
    let artListIdentifire = String(describing: ArtListCell.self)
    private var cancellables: Set<AnyCancellable> = []
    
    /// UI Components
    
    private var collectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 15, height: 200)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: collectionViewLayout)
        collectionView.accessibilityIdentifier = "list_collection_view"
        collectionView.register(ArtListCell.self, forCellWithReuseIdentifier: "ArtListCell")
        collectionView.register(ArtCollectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "ArtCollectionHeader")
        collectionView.bounces = true
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIProperty()
        configureTableView()
        bindViewModel()
        getApiCall()
    }
    
    fileprivate func setUpUIProperty() {
        self.navigationItem.title = L10n.Label.artCollection
        self.view.addSubview(collectionView)
        
        view.setNeedsUpdateConstraints()
        self.updateViewConstraints()
    }
    
    private func configureTableView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func updateViewConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        super.updateViewConstraints()
    }
    
    private func bindViewModel() {
        
        viewModel.objectWithError.sink { value in
            self.hideIndicator()
            self.showAlert(title: L10n.Error.title,
                           message: value,
                           alertStyle: .alert,
                           actionTitles: [L10n.Alert.cancelButton],
                           actionStyles: [.default],
                           actions: [{ _ in }])
        }.store(in: &cancellables)
        
        viewModel.objectWillChange.sink { [weak self] in
            guard let self = self else {
                return
            }
            self.collectionView.reloadData()
            self.hideIndicator()
        }.store(in: &cancellables)
    }
    
    func getApiCall() {
        Task{
            self.showIndicator(withTitle: L10n.loading, and: "")
            await self.viewModel.getArtCollection()
        }
    }
}
