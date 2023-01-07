//
//  PostCVC.swift
//  Express Courier
//
//  Created by apple on 06/01/23.
//

protocol PostCVCDelegate{
    func didSelected(index: Int)
}

import UIKit

class PostCVC: UICollectionViewCell {

    static let identifier = "PostCVC"
    static func nib()->UINib{return UINib(nibName: identifier, bundle: nil)}
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(PostInsideTVC.nib(), forCellReuseIdentifier: PostInsideTVC.identifier)
            tableView.separatorStyle = .none
        }
    }
    
    var scrollHeight = 0.0

    var delegate: PostCVCDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

//MARK: Table View
extension PostCVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostInsideTVC.identifier, for: indexPath) as! PostInsideTVC
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollHeight = scrollView.contentOffset.y
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "scrollNav"), object: nil, userInfo: ["height":scrollHeight])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelected(index: indexPath.row)
    }
}
