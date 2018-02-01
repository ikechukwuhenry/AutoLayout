//
//  SwipingController.swift
//  Autolayout
//
//  Created by Ikechukwu Michael on 23/01/2018.
//  Copyright © 2018 Ikechukwu Michael. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    let pages = [Page(imageName:"bear_first",headerText: "Join us in our fun and games!",
//                      bodyText: "Are you ready for loads and loads of fun?\n Don't wait for any longer! We hope to see you in our store soon."),
//                 Page(imageName:"heart_second",headerText: "Subscribe and get coupon on our daily event",
//                      bodyText: "we are doing great job from our cubicle. dont wait to long before you join"),
//                 Page(imageName:"wall_paper",headerText: "VIP members special event",
//                      bodyText: "Is going to be a great retreat and exclusive party. You don want to miss it"),
//                 Page(imageName:"images-13",headerText: "Join us in our fun and games!",
//                      bodyText: "Are you ready for loads and loads of fun?\n Don't wait for any longer! We hope to see you in our store soon."),
//                 Page(imageName:"quote",headerText: "Subscribe and get coupon on our daily event",
//                      bodyText: "we are doing great job from our cubicle. dont wait to long before you join"),
//                 Page(imageName:"mambilla",headerText: "VIP members special event",
//                      bodyText: "Is going to be a great retreat and exclusive party. You don want to miss it"),
//                 Page(imageName: "images-11",headerText: "Join us in our fun and games!",
//                      bodyText: "Are you ready for loads and loads of fun?\n Don't wait for any longer! We hope to see you in our store soon."),
//                 Page(imageName:"images-12",headerText: "Subscribe and get coupon on our daily event",
//                      bodyText: "we are doing great job from our cubicle. dont wait to long before you join"),
//                 Page(imageName:"leaf_third",headerText: "VIP members special event",
//                      bodyText: "Is going to be a great retreat and exclusive party. You don want to miss it")]
    var pages:[Page] = [Page]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        if let path = Bundle.main.path(forResource: "pages", ofType: "json")  {
           
            let page_data = NSData(contentsOfFile: path)
            guard let data = page_data else { return }
            do{
                pages = try JSONDecoder().decode([Page].self, from: data as Data)
            }catch let err { print(err) }
        }
        
        setUpBottomControls()
        
    }
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Prev", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.mainPink, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: UIPageControl = {
        let currentPageControl = UIPageControl()
        currentPageControl.currentPage = 0
        currentPageControl.numberOfPages = pages.count
        currentPageControl.currentPageIndicatorTintColor = .mainPink
        currentPageControl.pageIndicatorTintColor = .gray
        return currentPageControl
    }()
    
    @objc private func handleNext(){
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1) 
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handlePrev(){
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    fileprivate func setUpBottomControls(){
        // set the layout of the bottom uielements using stackview layout
        let bottomStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillEqually
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            // previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50),
            ])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        // cell.bearImageView.image = UIImage(named: page.imageName)
        // cell.descriptionTextView.text = page.headerText
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
            pageControl.currentPage = Int(x / view.frame.width)
    }
    
    // correct the display on rotation(landscape mode)
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: {(_) in
            self.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        })
        {(_) in }
    }
}
