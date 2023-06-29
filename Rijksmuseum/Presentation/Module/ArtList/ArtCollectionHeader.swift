
//  Created by Gayan Dias on 28/06/2023.


import UIKit

class ArtCollectionHeader: UICollectionReusableView {
        
    var artTitleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "cell_art_title_label"
        label.textAlignment = .left
        label.text = L10n.Label.notAvailable
        label.font = .ubuntuBolt(size: 18)
        label.textColor = UIColor.init(named: "textColor")
        label.layer.masksToBounds = true
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIProperty()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Set UIProperty
    
    fileprivate func setUpUIProperty() {
        self.addSubview(self.artTitleLabel)
        self.setConstraintsForUIProperties()
    }
    
    /// Set Constraints
    
    fileprivate func setConstraintsForUIProperties() {
        
        self.artTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left).offset(+10)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
}
