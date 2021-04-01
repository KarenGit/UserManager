//
//  UserListViewModel.swift
//  UserManager
//
//  Created by Karen Madoyan on 2021/3/28.
//

import Foundation

class UserListViewModel {
    private var perPage: Int
    private var page = 1
    private var total = 0
    private var totalPages = 0
    private var isLoadingStarted = true
    private var realm = AppSettings.shared.realm
    var userModels: [UserModel] = [UserModel]() {
        didSet {
            self.reloadTableViewClosure()
        }
    }
    
    
    // MARK: - Closures -
    
    private var reloadTableViewClosure: () -> ()
    
    
    init(_ perPage: Int, _ page: Int, reloadTableViewClosure: @escaping () -> ()) {
        self.perPage = perPage
//        self.page = page
        self.reloadTableViewClosure = reloadTableViewClosure
    }
    
    
    // MARK: - Fetching functions -
    
    func fetchData(completion: @escaping ((Int, Int, Bool) -> Void)) {
        self.isLoadingStarted = false
        HTTPClient.getRequest(endpoint: "\(Bundle.InfoPlistKeys.BaseURLs.Development.value)?page=\(self.page)&per_page=\(self.perPage)") { (_ result: Result<RequestResponse, Error>) in
            switch result {
            case .success(let data):
                completion(data.total, data.totalPages, (data.page < self.page))
                self.page += 1
                DispatchQueue.main.sync {
//                    self.deleteUserModel()
                    self.saveUserAction(data.users)
                    self.fetchSavedUsersData()
                }

            case .failure(let error):
                // TODO: Show Alert
                debugPrint(error)
//                self.fetchData()
            }
        }
    }
    
    func saveUserAction(_ users: [User]) {
//        users.forEach { (user) in
//            let isSaved = self.realm.objects(RealmUserModel.self).contains(where: { $0.id == user.id })
//            if !isSaved {
//                self.realm.beginWrite()
//                self.realm.add(RealmManager.addUserModel(user))
//                try! self.realm.commitWrite()
//            }
//        }
        var realmUserModels: [RealmUserModel] = []
        users.forEach { (user) in
            let isSaved = self.realm.objects(RealmUserModel.self).contains(where: { $0.id == user.id })
            if !isSaved {
                realmUserModels.append(RealmManager.addUserModel(user))
            }
        }
        self.realm.beginWrite()
        self.realm.add(realmUserModels)
        try! self.realm.commitWrite()
    }
    
    func fetchSavedUsersData() {
        let data = self.realm.objects(RealmUserModel.self)
        let jsonData = try! JSONEncoder().encode(data)
        guard let users = try? JSONDecoder().decode([User].self, from: jsonData) else { return }
        
        var models: [UserModel] = []
        for user in users {
            models.append(UserModel(user: user))
        }
        
        self.userModels = models
        // TODO: remove
        debugPrint(#function)
        debugPrint(self.userModels)
    }
    
    // TODO: remove
    func deleteUserModel() {
        DispatchQueue.main.async {
            autoreleasepool {
                let model = self.realm.objects(RealmUserModel.self).filter({ (userModel) -> Bool in
                    return true
                })
                if !model.isEmpty {
                    try! self.realm.write {
                        self.realm.delete(model)
                    }
                }
            }
        }
    }
    
    
    // MARK: - Retrieve Data -
    
    func getData(at indexPath: IndexPath ) -> UserModel {
        return userModels[indexPath.row]
    }
}
