//
//  PageCell.swift
//  Autolayout
//
//  Created by Ikechukwu Michael on 23/01/2018.
//  Copyright © 2018 Ikechukwu Michael. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page:Page? {
        didSet{
            guard let unwrappedPage = page else { return }
            bearImageView.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes:
                [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
            // let textBody = "\n\n\nAre you ready for loads and loads of fun?\n Don't wait for any longer! We hope to see you in our store soon."
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes:
                [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
                 NSAttributedStringKey.foregroundColor: UIColor.gray]))
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    // {} is refered to as closure or anonymous function
    private let bearImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        let text = "Join us in our fun and games!"
        let attributedText = NSMutableAttributedString(string: text, attributes:
            [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        let textBody = "\n\n\nAre you ready for loads and loads of fun?\n Don't wait for any longer! We hope to see you in our store soon."
        attributedText.append(NSMutableAttributedString(string: textBody, attributes:
            [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
             NSAttributedStringKey.foregroundColor: UIColor.gray]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implementated")
    }
    
    private func setupLayout(){
        // enable  autolayout for the image view
        // zuckImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let topImageViewContainer = UIView()
        addSubview(topImageViewContainer)
        addSubview(descriptionTextView)
        // topImageViewContainer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        topImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        topImageViewContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageViewContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        //            topImageViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //            topImageViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topImageViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageViewContainer.addSubview(bearImageView)
        bearImageView.centerXAnchor.constraint(equalTo: topImageViewContainer.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topImageViewContainer.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.5).isActive = true
        
        // add description view lay out
        descriptionTextView.topAnchor.constraint(equalTo: topImageViewContainer.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
    }
    

}
