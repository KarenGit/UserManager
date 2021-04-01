//
//  UsersListViewController.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/28.
//

import UIKit

class UsersListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var loadingCellid = "loadingcellid"
    private var cellHeight: CGFloat = 110
    private lazy var perPage: Int = Int(self.view.bounds.height / cellHeight)
    private var page = 1
    private var total = 0
    private var totalPages = 0
    private var isStopScrolling: Bool = false
    private let savedUsers = AppSettings.shared.realm.objects(RealmUserModel.self)
    private lazy var userListViewModel = UserListViewModel(self.perPage,
                                                           self.page,
                                                           reloadTableViewClosure: {
                                                            self.reloadData()
                                                           })

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLoadingCell()
        if savedUsers.isEmpty {
            self.fetchData()
        } else {
            self.userListViewModel.fetchSavedUsersData()
        }
    }
    
    
    // MARK: - Private Methods -
    
    private func configureLoadingCell() {
        let loadingCellNib = UINib(nibName: LoadingCell.typeName, bundle: nil)
        self.tableView.register(loadingCellNib, forCellReuseIdentifier: self.loadingCellid)
    }
    
    private func fetchData() {
        self.userListViewModel.fetchData(completion: { [weak self] (total, totalPages, isStoped) in
            self?.total = total
            self?.totalPages = totalPages
            self?.isStopScrolling = isStoped
        })
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - UIScrollViewDelegate -
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard !decelerate else { return }
        
        calculateContentSize(for: scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        calculateContentSize(for: scrollView)
    }
    
    private func calculateContentSize(for scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY >= contentHeight - scrollView.frame.height && !self.isStopScrolling {
            self.fetchData()
        }
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate -

extension UsersListViewController: UITableViewDataSource & UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return self.userListViewModel.userModels.count
        case 1: return (self.userListViewModel.userModels.count < self.total ? 1 : 0)
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: self.loadingCellid, for: indexPath) as! LoadingCell
            loadingCell.loadingActivityIndicator.startAnimating()
            return loadingCell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.typeName) as? UserTableViewCell else { return UITableViewCell() }

        cell.selectionStyle = .none
        cell.userModel = userListViewModel.getData(at: indexPath)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (indexPath.section == 0 ? UITableView.automaticDimension : 100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userDetailsViewController = UserDetailsViewController()
        userDetailsViewController.userDetailsViewModel = UserDetailsViewModel(self.userListViewModel.getData(at: indexPath))
        self.push(userDetailsViewController)
    }
}
