
//  Created by Gayan Dias on 28/06/2023.

import UIKit
import SnapKit

class ArtListCell: UICollectionViewCell {
    
    private var artImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.accessibilityIdentifier = "cell_art_image_view"
        imgView.contentMode = .scaleAspectFill
        imgView.layer.masksToBounds = true
        imgView.layer.cornerRadius = 4.0
        imgView.image = UIImage(named: "bckground")
        return imgView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "cell_title_label"
        label.textAlignment = .left
        label.text = L10n.Label.notAvailable
        label.font = .ubuntuItalic(size: 18)
        label.textColor = UIColor.white
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        label.layer.cornerRadius = 4.0
        label.backgroundColor = UIColor.black.withAlphaComponent(0.4)
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
        self.contentView.addSubview(self.artImgView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.setNeedsUpdateConstraints()
        self.setConstraintsForUIProperties()
    }
    
    /// Set Constraints
    
    fileprivate func setConstraintsForUIProperties() {
        
        self.artImgView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left).offset(+5)
            make.right.equalTo(self.contentView.snp.right).offset(-5)
            make.height.equalTo(50)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
        }
    }
    
    /// Set lable value
    
    func setValues(art: Art) {
        titleLabel.text = art.title
        titleLabel.font = .ubuntuItalic(size: 17)
        self.artImgView.setCustomImage(art.headerImage.url)
    }
}
