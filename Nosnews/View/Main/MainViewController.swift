//
//  ViewController.swift
//  Nosnews
//
//  Created by Arif Luthfiansyah on 27/08/19.
//  Copyright © 2019 Ayo Development. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Component View
    @IBOutlet weak var mLeftBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var mRightBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var mTableView: UITableView!
    
    // MARK: - Dependency
    private let newsViewModel = NewsViewModel()
    private let progressView = ALProgressIndicatorView(withMessage: nil)
    
    // MARK: - Variable
    var keyCategory = ""
    var keyCountry = ""
    
    // MARK: - UIViewController's Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.keyCategory.isEmpty {
            self.keyCategory = NewsPreferences.value(defaultValue: "technology",
                                                     forKey: NewsPreferences.KeyCategory)
        }
        if self.keyCountry.isEmpty {
            self.keyCountry = NewsPreferences.value(defaultValue: "id",
                                                    forKey: NewsPreferences.KeyCountry)
        }
        
        self.title = "Top Headlines"
        self.mLeftBarButtonItem.title = self.keyCategory.uppercased()
        self.mRightBarButtonItem.title = self.keyCountry.capitalized
        
        self.setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.attemptFetchHeadlines()
    }
    
    // MARK: - Private's Function
    private func attemptFetchHeadlines() {
        guard !self.keyCountry.isEmpty, !self.keyCategory.isEmpty else {
            return
        }
        
        self.progressView.show(superView: self.view)
        
        self.newsViewModel
            .fetchHeadlines(from: self.keyCountry, in: self.keyCategory, key: R.String.apiKey) { (state) in
                switch state {
                case .success: self.onFetchHeadlinesSuccess()
                case .failure: self.onFetchHeadlineFailure()
                }
        }
    }
    
    private func onFetchHeadlinesSuccess() {
        DispatchQueue.main.async {
            self.mTableView.reloadData()
            self.progressView.dismiss()
        }
    }
    
    private func onFetchHeadlineFailure() {
        guard let message = self.newsViewModel.message else { return }
        self.showAlert(title: "Error", message: message, completion: nil)
    }
    
    private func setupTableView() {
        self.mTableView.dataSource = self
        self.mTableView.delegate = self
    }
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsViewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        let article = self.newsViewModel.articles[indexPath.row]
        
        for index in 0...Constant.articleCountryCode.count - 1 {
            if (Constant.articleCountryCode[index] == self.keyCountry) {
                cell.mCountryLabel.text = Constant.articleCountry[index]
            }
        }
        
        cell.configure(with: article)
        
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ArticleTableViewCell.heigth
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard !self.newsViewModel.articles.isEmpty else {
            return
        }
        
        let article = self.newsViewModel.articles[indexPath.row]
        
        self.showArticle(article: article)
    }
    
    func showArticle(article: Article) {
        let storyboard = UIStoryboard(name: "Article", bundle: Bundle.main)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ArticleViewController") as? ArticleViewController else {
            return
        }
        
        viewController.article = article
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
