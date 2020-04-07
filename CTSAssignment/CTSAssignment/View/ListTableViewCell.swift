//
//  ListTableViewCell.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import UIKit

/// Class for holding each detail of item which we had from api  Which its going to show image , title and description
class ListTableViewCell: UITableViewCell {
    
  private  let imageview = UIImageView() 
  private  let nameLabel = UILabel()
  private  let detailLabel = UILabel()
   
    
    /// Tableviewcell  methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageview) /// Adding image view in  cell container
        contentView.addSubview(nameLabel) /// Adding title label in  cell container
        contentView.addSubview(detailLabel) /// Adding sublabel or description label in cell container
        addConstraints() // adding contarints on all subview which added on cell container
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Adding autolayout constraints on Imageview based on its supperview ie container
    /// - Parameter marginGuide: passing suuper layout marginal guide
    fileprivate func addCOnstraintsImageView(_ marginGuide: UILayoutGuide) {
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageview.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
    }
    
    /// Adding autolayout constraints on title Label based on its supperview ie container
    /// - Parameter marginGuide: passing supperview marginal layout (container layout)
    fileprivate func addconstraintsTitltLbl(_ marginGuide: UILayoutGuide) {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: imageview.trailingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
    }
    
    /// Adding autolayout constraints on detail or description Label based on its supperview ie container
    /// - Parameter marginGuide: passing supperview marginal layout (container layout)
    fileprivate func addconstraintsdescription(_ marginGuide: UILayoutGuide) {
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: -10).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont(name: "Avenir-Book", size: 15)
        detailLabel.textColor = UIColor.lightGray
        
    }
    
    /// Grouping all subviews Autolayout costarints
    private func addConstraints() {
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        let marginGuide = contentView.layoutMarginsGuide
        addCOnstraintsImageView(marginGuide)
        addconstraintsTitltLbl(marginGuide)
        addconstraintsdescription(marginGuide)
   }
    
    /// Computed propert for seeting data in each cell
    var rowModel : Rows? {
        didSet {
            guard let rowmodel = rowModel else {  return }
            nameLabel.text = rowmodel.title
            detailLabel.text = rowmodel.description
            imageview.loadImageUsingCache(withUrl: rowmodel.imageHref)
        }
    }
    

}




