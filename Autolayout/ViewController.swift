//
//  ViewController.swift
//  Autolayout
//
//  Created by Ikechukwu Michael on 22/01/2018.
//  Copyright © 2018 Ikechukwu Michael. All rights reserved.
//

import UIKit

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1.0)
}

class ViewController: UIViewController {
    
    // let's avoiding polluting viewDidLoad
    
    // {} is refered to as closure or anonymous function
    let bearImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        }()
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        let text = "Join us in our fun and games!"
        // textView.font = UIFont.boldSystemFont(ofSize: 18)
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
    
    private let previousButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
       return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.mainPink, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pageControl: UIPageControl = {
       let currentPageControl = UIPageControl()
        currentPageControl.currentPage = 0
        currentPageControl.numberOfPages = 4
        currentPageControl.currentPageIndicatorTintColor = .mainPink
        currentPageControl.pageIndicatorTintColor = .gray
        return currentPageControl
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Here is our entry into the app
        // let imageView = UIImageView(image: #imageLiteral(resourceName: "zuckprofile"))
        // view.addSubview(bearImageView)
        view.addSubview(descriptionTextView)
        // view.addSubview(footerTextView)
        setUpBottomControls()
        setupLayout()
        
    }
    
    fileprivate func setUpBottomControls(){
        // view.addSubview(previousButton)
       
        let bottomStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStackView)
        bottomStackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            // previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50),
            ])
        
    }
    
    private func setupLayout(){
        // enable  autolayout for the image view
        // zuckImageView.translatesAutoresizingMaskIntoConstraints = false
        
    let topImageViewContainer = UIView()
        view.addSubview(topImageViewContainer)
        // topImageViewContainer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        topImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        topImageViewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageViewContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
//            topImageViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//            topImageViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topImageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageViewContainer.addSubview(bearImageView)
        bearImageView.centerXAnchor.constraint(equalTo: topImageViewContainer.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topImageViewContainer.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topImageViewContainer.heightAnchor, multiplier: 0.5).isActive = true
        
        
        // bearImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // zuckImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        // bearImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        // bearImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        // bearImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // add description view lay out
        descriptionTextView.topAnchor.constraint(equalTo: topImageViewContainer.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        // add layout for the footertextview
        // footerTextView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 30).isActive = true
        // footerTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        // footerTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        // footerTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

