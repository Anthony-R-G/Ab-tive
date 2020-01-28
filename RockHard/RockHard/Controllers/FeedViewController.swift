//  ViewController.swift
//  RockHard
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Rockstars. All rights reserved.

import UIKit

class FeedViewController: UIViewController {
    //MARK: - Properties
    
    var topics = ["Diets", "Style", "aflkafjal", "Weight Loss", "gymAccessories"]
    
    var messages = ["Found Water Bottle", "Legs Workout 6:30PM", "Lost 20lbs in 3 weeks" ]

    
    lazy var feedOptionCollView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let horizontalCollView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        horizontalCollView.translatesAutoresizingMaskIntoConstraints = false
        horizontalCollView.register(FeedHorizontalCollViewCell.self, forCellWithReuseIdentifier: "topicsCell")
        layout.scrollDirection = .horizontal
        horizontalCollView.backgroundColor = #colorLiteral(red: 0.776026845, green: 0.7714150548, blue: 0.7795727849, alpha: 1)
        horizontalCollView.dataSource = self
        horizontalCollView.delegate = self
        
        return horizontalCollView
    }()
    //MARK: - Constraints

    private func feedCollViewConstraints() {
        view.addSubview(feedOptionCollView)
        feedOptionCollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            feedOptionCollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        feedOptionCollView.heightAnchor.constraint(equalToConstant: 140),
        feedOptionCollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        
        
      ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollViewConstraints()
        view.backgroundColor = .gray
        
        
    }

}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicsCell", for: indexPath) as? FeedHorizontalCollViewCell else { return UICollectionViewCell()
        }
        
        let specificTopic = topics[indexPath.row]
        print(specificTopic)
        cell.label.text = specificTopic
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let specificTopic = topics[indexPath.row]
        
        
        print("You clicked on \(specificTopic) on the \(indexPath.row) row")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 105)
    }
    
}



