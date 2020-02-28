//  ViewController.swift
//  RockHard
//  Created by Anthony Gonzalez on 1/27/20.
//  Copyright © 2020 Rockstars. All rights reserved.

import UIKit
import Firebase
import Kingfisher



class FeedViewController: UIViewController {
    //MARK: - Properties
    
    let userID = FirebaseAuthService.manager.currentUser?.uid
    var userName = String() {
        didSet {
            print(userName)
        }
    }
    
    var topics = ["All", "Diets", "Weight Loss", "Gym Accessories"]
    
    
    var feedPosts = [Post](){
        didSet {
            feedPostCollectionView.reloadData()
        }
    }
    
    
    lazy var feedOptionCollView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let horizontalCollView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        horizontalCollView.translatesAutoresizingMaskIntoConstraints = false
        horizontalCollView.register(FeedHorizontalCollViewCell.self, forCellWithReuseIdentifier: "topicsCell")
        layout.scrollDirection = .horizontal
        horizontalCollView.backgroundColor = .clear
        horizontalCollView.dataSource = self
        horizontalCollView.delegate = self
        
        return horizontalCollView
    }()
    
    
    lazy var feedPostCollectionView: UICollectionView = {
        let verticalCollView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        verticalCollView.register(FeedVerticalCollViewCell.self, forCellWithReuseIdentifier: "feedPostCell")
        verticalCollView.backgroundColor = .clear
        verticalCollView.dataSource = self
        verticalCollView.delegate = self
        return verticalCollView
    }()
    
    lazy var addButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.8403362632, green: 0.4548202157, blue: 0.4165673852, alpha: 1)
        button.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        return button
    }()
    
    private func getUserNameString() {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userID!)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let property = document.get("userName"){
                    self.userName = "\(property)"
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    private func loadAllFeedPosts() {
        DispatchQueue.global(qos: .userInitiated).async {
            FirestoreService.manager.getAllPost { (result) in
                switch result {
                case .success(let feedPostsFromFirebase):
                    self.feedPosts = feedPostsFromFirebase
                    
                case .failure(let error):
                    Utilities.showAlert(vc: self, message: error.localizedDescription)
                }
            }
        }
    }
    
    
    @objc private func addButtonPressed() {
        let addPostVC = AddPostViewController()
        addPostVC.userName = self.userName
        addPostVC.delegate = self
        self.present(addPostVC, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        view.backgroundColor = .clear
        getUserNameString()
        loadAllFeedPosts()
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "feedvcdark")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
    }
}


//MARK: --Constraints
extension FeedViewController {
    private func setConstraints(){
        [feedOptionCollView, feedPostCollectionView, addButton].forEach{view.addSubview($0)}
        [feedOptionCollView, feedPostCollectionView, addButton].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        
        setTopicCollViewConstraints()
        setPostsCollViewConstraints()
        setAddButtonConstraints()
        
    }
    
    private func setTopicCollViewConstraints() {
        NSLayoutConstraint.activate([
            feedOptionCollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedOptionCollView.heightAnchor.constraint(equalToConstant: 120),
            feedOptionCollView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func setPostsCollViewConstraints(){
        NSLayoutConstraint.activate([
            feedPostCollectionView.topAnchor.constraint(equalTo: feedOptionCollView.bottomAnchor),
            feedPostCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -55),
            feedPostCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setAddButtonConstraints() {
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 25),
            addButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}


extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.feedPostCollectionView {
            return feedPosts.count
        } else {
            return topics.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView  == self.feedPostCollectionView {
            
            guard let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedPostCell", for: indexPath) as? FeedVerticalCollViewCell else { return UICollectionViewCell()}
            let specificPost = feedPosts[indexPath.row]
            feedCell.feedPostImage.kf.setImage(with: URL(string: specificPost.postPicture))
            feedCell.feedPostLabel.text = specificPost.postText
            feedCell.userNameLabel.text = specificPost.userName
            feedCell.backgroundColor = .darkGray
            return feedCell
        } else {
            guard let topicsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicsCell", for: indexPath) as? FeedHorizontalCollViewCell else { return UICollectionViewCell()}
            
            let specificTopic = topics[indexPath.row]
            topicsCell.label.text = specificTopic
            return topicsCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == feedPostCollectionView {
            return CGSize(width: 360, height: 470)
        } else {
            return CGSize(width: 130, height: 85)
        }
    }
}

extension FeedViewController: loadFeedPostsDelegate {
    func loadAllPosts() {
            self.loadAllFeedPosts()
        }
}




