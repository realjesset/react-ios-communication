//
//  TopBarView.swift
//  UDC
//
//  Created by Ashish Pisey on 28/08/22.
//

import UIKit

class TopBarView: UIView {
    private static let NIB_NAME = "TopBarView"
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    
    override func awakeFromNib() {
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(TopBarView.NIB_NAME, owner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                contentView.topAnchor.constraint(equalTo: topAnchor),
                contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
                contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
                contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }
    
}
