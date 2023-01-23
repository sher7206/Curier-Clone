
//  NewsVC.swift
//  100kExpress
//  Created by apple on 05/12/22.

import UIKit
import SDWebImage

class NewsVC: UIViewController {
    
    @IBOutlet weak var textLbl: UILabel!
    
    var news: [GetNewsData] = []
    var currentPage: Int = 1
    var totalItems: Int = 0
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(NewTVC.nib(), forCellReuseIdentifier: NewTVC.identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textLbl.isHidden = true
        uploadNews(page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Yangiliklar"
        tabBarController?.tabBar.isHidden = true
        

    }
    

    func uploadNews(page: Int) {
        Loader.start()
        let getNews = UserService()
        getNews.getNews(model: GetNewsRequest(page: page)) { result in
            switch result {
            case.success(let content):
                Loader.stop()
                guard let data = content.data else {return}
                self.totalItems = content.meta?.total ?? 0
                self.news.append(contentsOf: data)
                if self.news.count == 0 {
                    self.textLbl.isHidden = false
                } else {
                    self.textLbl.isHidden = true
                }
                self.tableView.reloadData()
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: TABLE VIEW
extension NewsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewTVC.identifier, for: indexPath) as! NewTVC
        cell.selectionStyle = .none
        
        let data = news[indexPath.row]
        cell.updateCell(date: data.created_at ?? "", imgV: data.image ?? "" , title: data.title ?? "", desc: data.description ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AboutNewVC()
        let data = news[indexPath.row]
        vc.dates = data
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == news.count - 1 {
            //            Loader.start()
            if self.totalItems > news.count {
                self.currentPage += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    Loader.stop()
                    self.uploadNews(page: self.currentPage)
                    self.tableView.reloadData()
                }
            }
        }
    }
}
