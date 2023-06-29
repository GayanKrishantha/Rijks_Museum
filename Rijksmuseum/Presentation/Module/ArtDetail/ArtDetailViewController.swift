
//  Created by Gayan Dias on 28/06/2023.


import UIKit
import Combine

class ArtDetailViewController: UIViewController {
    
    var viewModel: ArtDetailViewModel!
    let jobSearchcellIdentifier = String(describing: ArtListCell.self)
    private var cancellables: Set<AnyCancellable> = []
        
    let detailListView: UITableView = {
        let tableView = UITableView()
        tableView.accessibilityIdentifier = "detail_list_view"
        let header = StretchyTableHeaderView(frame: CGRect(x: 0,
                                                           y: 0,
                                                           width: UIScreen.main.bounds.size.width,
                                                           height: UIScreen.main.bounds.size.width))
        header.detailImageView.image = UIImage(named: "detail_background")
        tableView.tableHeaderView = header
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIProperty()
        configureTableView()
        bindViewModel()
        getApiCall()
    }
    
    private func configureTableView() {
        detailListView.delegate = self
        detailListView.dataSource = self
    }
    
    fileprivate func setUpUIProperty() {
        self.navigationItem.title = viewModel.artItem.objectNumber
        self.view.addSubview(self.detailListView)
        
        view.setNeedsUpdateConstraints()
        self.updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        detailListView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        super.updateViewConstraints()
    }
    
    @objc func backButtonClicked(sender: UIButton){
        viewModel.navigateBackToListView()
    }
    
    @objc func fullScreenButtonClicked(sender: UIButton){
        viewModel.navigateBackToListView()
    }
    
    private func bindViewModel() {
        
        self.viewModel.objectWithError.sink { value in
            self.hideIndicator()
            self.showAlert(title: "Error!",
                           message: value,
                           alertStyle: .alert,
                           actionTitles: ["Cancel"],
                           actionStyles: [.default],
                           actions: [{ _ in
                self.viewModel.navigateBackToListView()
            }])
        }.store(in: &cancellables)
        
        viewModel.objectWillChange.sink { [weak self] in
            guard let self = self else {
                return
            }
            self.hideIndicator()
            let artDetail = self.viewModel.artCollectionDetail?.artObject
            guard let header = self.detailListView.tableHeaderView as? StretchyTableHeaderView else {return}
            header.setValues(art: artDetail!)
            self.detailListView.reloadData()
        }.store(in: &cancellables)
    }
    
    private func getApiCall() {
        Task{
            self.showIndicator(withTitle: L10n.loading, and: "")
            Task {await self.viewModel.getSelectedArtDetail(objectNumber: viewModel.artItem.objectNumber)}
        }
    }
}
