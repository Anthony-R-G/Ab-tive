//  ViewController.swift
//  RockHard
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Rockstars. All rights reserved.

import UIKit

class FeedViewController: UIViewController {
    //MARK: - Properties
    
    var topics = ["Diets", "Style", "aflkafjal", "Weight Loss", "gymAccessories"]
    

    var testData = [FeedPost]() {
        didSet {
            feedPostCollectionView.reloadData()
        }
    }

    var messages = ["Found Water Bottle", "Legs Workout 6:30PM", "Lost 20lbs in 3 weeks" ]
    
    lazy var feedOptionCollView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let horizontalCollView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        horizontalCollView.translatesAutoresizingMaskIntoConstraints = false
        horizontalCollView.register(FeedHorizontalCollViewCell.self, forCellWithReuseIdentifier: "topicsCell")
        layout.scrollDirection = .horizontal

        horizontalCollView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        horizontalCollView.dataSource = self
        horizontalCollView.delegate = self
        
        return horizontalCollView
    }()

    
    lazy var feedPostCollectionView: UICollectionView = {
        
        let verticalCollView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        verticalCollView.register(FeedVerticalCollViewCell.self, forCellWithReuseIdentifier: "feedPostCell")
        verticalCollView.backgroundColor = .brown
        verticalCollView.dataSource = self
        verticalCollView.delegate = self
        return verticalCollView
        
    }()

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testData = FeedPost.testFeedData
        setConstraints()
        view.backgroundColor = .gray
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.feedPostCollectionView.reloadData()
            print(self.testData)
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 105)
    }
    
}


//MARK: --Constraints
extension FeedViewController {
    private func setConstraints(){
        [feedOptionCollView, feedPostCollectionView].forEach{view.addSubview($0)}
        [feedOptionCollView, feedPostCollectionView].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        
        setTopicCollViewConstraints()
        setPostsCollViewConstraints()
        
    }
    
    private func setTopicCollViewConstraints() {
        NSLayoutConstraint.activate([
            feedOptionCollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedOptionCollView.heightAnchor.constraint(equalToConstant: 140),
            feedOptionCollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func setPostsCollViewConstraints(){
        NSLayoutConstraint.activate([
            feedPostCollectionView.topAnchor.constraint(equalTo: feedOptionCollView.bottomAnchor),
            feedPostCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            feedPostCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
}
extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.feedPostCollectionView {
            return 3
            
        } else {
            return topics.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView  == self.feedPostCollectionView {
            
            guard let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedPostCell", for: indexPath) as? FeedVerticalCollViewCell else { return UICollectionViewCell()}
            print("v")
            let specificTestData = testData[indexPath.row]
            feedCell.feedPostImage.image = UIImage(named: specificTestData.contentPicture)
            feedCell.backgroundColor = .darkGray
            return feedCell
        } else {
            guard let topicsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicsCell", for: indexPath) as? FeedHorizontalCollViewCell else { return UICollectionViewCell()}
            print("h")
            let specificTopic = topics[indexPath.row]
            topicsCell.label.text = specificTopic
            return topicsCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == feedPostCollectionView {
            return CGSize(width: 360, height: 470)
        } else {
            return CGSize(width: 130, height: 105)
           
            
        }
        
    }
}




