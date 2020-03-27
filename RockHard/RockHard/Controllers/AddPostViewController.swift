//
//  AddPostViewController.swift
//  RockHard
//
//  Created by Anthony Gonzalez on 2/3/20.
//  Copyright © 2020 Rockstars. All rights reserved.
//
import UIKit

class AddPostViewController: UIViewController {
    
    //MARK: -- Properties
    var feedVC = FeedViewController ()
    
    lazy var addPostLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Post"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.textColor = .white
        return label
    }()
    
    lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(imagePressed), for: .touchUpInside)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    lazy var feedPostImage: UIImageView = {
        let myImage = UIImageView()
        myImage.isUserInteractionEnabled = true
        myImage.image = #imageLiteral(resourceName: "cameraPlaceholder")
        myImage.backgroundColor = .clear
        myImage.layer.cornerRadius = 10
        myImage.clipsToBounds = true
        myImage.isHidden = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imagePressed))
        myImage.addGestureRecognizer(tapGesture)
        return myImage
    }()
    
    lazy var feedPostTextField: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.layer.cornerRadius = 10
        tv.isUserInteractionEnabled = true
        tv.font = UIFont.systemFont(ofSize: 23)
        tv.keyboardAppearance = .dark
        tv.delegate = self
        return tv
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.cyan, for: .normal)
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        button.showsTouchWhenHighlighted = true
        return button
    }()
    
    lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.text = "Tag"
        return label
    }()
    
    lazy var selectedTagLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7007705479)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.text = "Add Tag"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var createTopicView: UIView = {
        let topicView = UIView()
        topicView.alpha = 0.0
        topicView.backgroundColor = #colorLiteral(red: 0.2632220984, green: 0.2616633773, blue: 0.2644240856, alpha: 0.8305329623)
        topicView.layer.cornerRadius = 20
        topicView.clipsToBounds = true
        return topicView
    }()
    
    //MARK: - createTopicView UI Objects
    lazy var topicTableView: UITableView = {
        let topicTV = UITableView()
        topicTV.register(UITableViewCell.self, forCellReuseIdentifier: "topicCell")
    
        topicTV.backgroundColor = .systemYellow
        topicTV.tintColor = .systemGreen
        topicTV.delegate = self
        topicTV.dataSource = self
        return topicTV
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .lightGray
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(presentTopicSelection), for: .touchUpInside)
        return button
    }()
    
    var delegate: loadFeedPostsDelegate!
    
    var userName = String()
    
    var imageURL: String? = nil
    
    //MARK: -- Objective C Functions
    
    @objc private func presentTopicSelection() {
        view.backgroundColor = #colorLiteral(red: 0.2632220984, green: 0.2616633773, blue: 0.2644240856, alpha: 0.8305329623)
        UIView.animate(withDuration: 1.0) {
            self.createTopicView.alpha = 1.0
        }
    }
    
    @objc private func imagePressed(){
        presentImagePicker()
    }
    
 
    @objc private func submitButtonPressed(){
        
        if selectedTagLabel.text == "Add Tag" {
            Utilities.showAlert(vc: self, message: "You did not select a required tag")
        }
        else {
            guard let user = FirebaseAuthService.manager.currentUser else {return}
            let photoURL = imageURL != nil ? imageURL : "nil"
            guard let postText = feedPostTextField.text else {return}
            
            FirestoreService.manager.createPost(post: Post(userID: user.uid.description, userName: userName, postPicture: photoURL, postText: postText, topicTag: selectedTagLabel.text ?? "null")) { (result) in
                switch result {
                case .failure(let error):
                    Utilities.showAlert(vc: self, message: "\(error.localizedDescription)")
                case .success:
                    Utilities.showAlert(vc: self, message: "Message posted")
                    self.delegate?.loadAllPosts()
                }
            }
            
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: {
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                })
            }
        }

    }
    
    
    //MARK: -- Methods
    private func presentImagePicker(){
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePickerViewController.allowsEditing = true
        imagePickerViewController.mediaTypes = ["public.image"]
        imagePickerViewController.sourceType = .photoLibrary
        present(imagePickerViewController, animated: true, completion: nil)
    }
    
    private func setTextViewPlaceHolders () {
        feedPostTextField.textColor = .lightGray
        feedPostTextField.text = "Enter Message..."
    }
    
    //MARK: - createTopicViewConstraints - Eric's addition
    private func setCreateTopicViewConstraints(){
        view.addSubview(createTopicView)
        createTopicView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createTopicView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createTopicView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            createTopicView.heightAnchor.constraint(equalToConstant: 250),
            createTopicView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setTopicTableViewConstraints(){
        createTopicView.addSubview(topicTableView)
        topicTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topicTableView.leadingAnchor.constraint(equalTo: createTopicView.leadingAnchor),
            topicTableView.trailingAnchor.constraint(equalTo: createTopicView.trailingAnchor),
            topicTableView.bottomAnchor.constraint(equalTo: createTopicView.bottomAnchor),
            topicTableView.topAnchor.constraint(equalTo: createTopicView.topAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setTextViewPlaceHolders()
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
        setConstraints()
    }
}


//MARK: -- Constraints
extension AddPostViewController {
    
    private func setConstraints() {
        
        [feedPostImage, addPostLabel, feedPostTextField, submitButton, tagsLabel, selectedTagLabel, addButton, cameraButton].forEach{view.addSubview($0)}
        [feedPostImage, feedPostTextField, addPostLabel, submitButton , tagsLabel, selectedTagLabel, addButton, cameraButton].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        
        setFeedPostImageConstraints()
        setFeedPostTextFieldConstraints()
        setTitleLabelConstraints()
        setSubmitButtonConstraints()
        setTagsLabelConstraints()
        setPlusButtonConstraints()
        setSelectedTagLabelConstraints()
        setCameraButtonConstraints()
        //Eric's addition
        setCreateTopicViewConstraints()
        setTopicTableViewConstraints()
    }
    
    private func setSelectedTagLabelConstraints() {
        NSLayoutConstraint.activate([
            selectedTagLabel.centerYAnchor.constraint(equalTo: tagsLabel.centerYAnchor),
            selectedTagLabel.heightAnchor.constraint(equalToConstant: 30),
            selectedTagLabel.widthAnchor.constraint(equalToConstant: 100),
            selectedTagLabel.leadingAnchor.constraint(equalTo: tagsLabel.trailingAnchor, constant: 0)
        ])
    }
    
    private func setTagsLabelConstraints(){
        NSLayoutConstraint.activate([
            tagsLabel.leadingAnchor.constraint(equalTo: addPostLabel.leadingAnchor),
            tagsLabel.topAnchor.constraint(equalTo: addPostLabel.bottomAnchor, constant: 10),
            tagsLabel.heightAnchor.constraint(equalToConstant: 30),
            tagsLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            addPostLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPostLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            addPostLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addPostLabel.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    private func setFeedPostImageConstraints() {
        NSLayoutConstraint.activate([
            feedPostImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            feedPostImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            feedPostImage.heightAnchor.constraint(equalToConstant: 150),
            feedPostImage.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    private func setFeedPostTextFieldConstraints() {
        NSLayoutConstraint.activate([
            feedPostTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedPostTextField.topAnchor.constraint(equalTo: addPostLabel.bottomAnchor, constant: 50 ),
            feedPostTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.95),
            feedPostTextField.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    private func setCameraButtonConstraints(){
        NSLayoutConstraint.activate([
        cameraButton.trailingAnchor.constraint(equalTo: submitButton.trailingAnchor),
        cameraButton.heightAnchor.constraint(equalTo: tagsLabel.heightAnchor),
        cameraButton.widthAnchor.constraint(equalToConstant: 30),
        cameraButton.centerYAnchor.constraint(equalTo: tagsLabel.centerYAnchor)
        ])
    }
    
    
    private func setPlusButtonConstraints() {
        NSLayoutConstraint.activate([
            addButton.trailingAnchor.constraint(equalTo: cameraButton.leadingAnchor, constant: -10),
            addButton.heightAnchor.constraint(equalTo: tagsLabel.heightAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            addButton.centerYAnchor.constraint(equalTo: tagsLabel.centerYAnchor)
            
        ])
    }
    
    private func setSubmitButtonConstraints() {
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}


//MARK: -- Delegate Methods
extension AddPostViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == "" {
            textView.text = "Enter Message..."
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .white
        }
    }
}


extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        self.feedPostImage.isHidden = false
        self.feedPostImage.image = image
        dismiss(animated: true, completion: nil)
        
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        FirebaseStorageService.uploadManager.storeImage(image: imageData, completion: { [weak self] (result) in
            switch result{
            case .success(let url):
                self?.imageURL = url
                
            case .failure(let error):
                print(error)
            }
        })
    }
}

extension AddPostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedVC.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topicTableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)
        cell.textLabel?.text = feedVC.topics[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTagLabel.text = feedVC.topics[indexPath.row]
        
        UIView.animate(withDuration: 1) {
            self.createTopicView.alpha = 0
        }
    }
}
