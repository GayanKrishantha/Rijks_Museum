
//  Created by Gayan Dias on 28/06/2023.


import Foundation
import UIKit

class StretchyTableHeaderView: UIView {
    
    public let detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.accessibilityIdentifier = "detail_image_view"
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBotom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        createView()
        setViewConstrainsts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Create subview
    private func createView() {
        addSubview(containerView)
        containerView.addSubview(detailImageView)
    }
    
    /// Set up view constraints
    private func setViewConstrainsts() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: detailImageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBotom = detailImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBotom.isActive = true
        imageViewHeight = detailImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }
    
    /// Notify view of scroll change from container
    public func scrollViewDidScroll(scrolllView: UIScrollView) {
        containerViewHeight.constant = scrolllView.contentInset.top
        let offsetY = -(scrolllView.contentOffset.y + scrolllView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBotom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrolllView.contentInset.top, scrolllView.contentInset.top)
    }
    
    func setValues(art: ArtObject) {
        self.detailImageView.setCustomImage(art.webImage.url)
    }
}
