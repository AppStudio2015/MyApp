//
//  HomeTableViewCell.swift
//  MyApp
//
//  Created by PandoraXY on 2018/11/26.
//  Copyright © 2018 AppStudio. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    // MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
         super.layoutSubviews()
    }
    
    // MARK: - Override Functions

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Setters and Getters
    
    // MARK: - Private Functions
    
    // MARK: - Public Functions

}
