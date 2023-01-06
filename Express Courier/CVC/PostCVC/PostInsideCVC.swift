//
//  PostInsideCVC.swift
//  Express Courier
//
//  Created by apple on 06/01/23.
//

import UIKit

class PostInsideCVC: UICollectionViewCell {
    
    static let identifier = "PostInsideCVC"
    static func nib()->UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(PostTVC.nib(), forCellReuseIdentifier: PostTVC.identifier)
            tableView.separatorStyle = .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

//MARK: Table View
extension PostInsideCVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTVC.identifier, for: indexPath) as! PostTVC
        return cell
    }
}
