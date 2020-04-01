//
//  ViewController.swift
//  ResumeApp
//
//  Created by Perchy Fisher on 2020/3/22.
//  Copyright © 2020 卢怡萱. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var tableView : UITableView!
    var listData: [String] = [String]()
    var refreshControl : UIRefreshControl!
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.titleView = UIView()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(editAction))
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(LoadMoreTableCell.self, forCellReuseIdentifier: "LoadMoreTableCell")
        tableView.register(PersonalCell.self, forCellReuseIdentifier: "PersonalCell")
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = .systemRed
        
        for resume in fetchResume(type: 0) {
            listData.append(resume.name ?? "简历")
        }
        
        addPullToRefresh()
        
    }
    
    func addPullToRefresh() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .blue
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新中")
        self.tableView.addSubview(refreshControl)
    }
    
    @objc func editAction() {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(editAction))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(editAction))
            tableView.setEditing(true, animated: true)
        }
    }
    
    @objc func backAtion() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Core Data Saving support
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Models")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return listData.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalCell") as! PersonalCell
            cell.nameLabel.text = listData[indexPath.row]
            cell.iconView.image = UIImage(named: "icon")
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreTableCell", for: indexPath) as! LoadMoreTableCell
            cell.loadingView.startAnimating()
            return cell
        }
    }
}


extension ViewController :UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: false)
        let tmpVC : UIViewController! = ResumeViewController()
        
        self.navigationController?.pushViewController(tmpVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listData.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        listData.swapAt(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let loadMoreCell = cell as? LoadMoreTableCell {
                loadMoreCell.loadingView.startAnimating()
                loadMore()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if let loadMoreCell = cell as? LoadMoreTableCell {
                loadMoreCell.loadingView.stopAnimating()
            }
        }
    }
}

extension ViewController {
    @objc func handleRefresh(_ sender: UIRefreshControl) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
            for resume in self.fetchResume(type: 1) {
                self.listData.insert(resume.name ?? "西门大侠", at: 0)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func loadMore() {
        if !isLoading {
            isLoading = true
            DispatchQueue.global().async {
                sleep(2)
                let count = self.listData.count
                for index in 0..<3 {
                    self.listData.append("毕业生 \(count + index)")
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.isLoading = false
                }
            }
            
        }
    }
    
    func addResume(name: String, school: String, type: Int) {
        let resume = NSEntityDescription.insertNewObject(forEntityName: "Resume", into: persistentContainer.viewContext) as! Resume
        resume.name = name
        resume.school = school
        resume.type = Int16(type)
        saveContext()
    }
    
    func fetchResume(type : Int) -> [Resume] {
        let fetchRequest: NSFetchRequest = Resume.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type == %ld", Int16(type))
        
        do {
            let result: [Resume] = try persistentContainer.viewContext.fetch(fetchRequest)
            return result
        } catch let err {
            print("core data fetch error:", err)
        }
        return [Resume]()
    }
}
