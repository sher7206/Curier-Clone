
//  ChatVC.swift
//  Express Courier
//  Created by apple on 11/01/23.

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var chatTF: UITextField!
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(ChatTVC.nib(), forCellReuseIdentifier: ChatTVC.identifier)
            tableView.separatorStyle = .none
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        }
    }
    
    var id = 0
    var chats: [GetChatResponse] = []
    var page = 1
    var totalMessages = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        getChatAPI(page: page)
    }
    
    func setUpNavigation(){
        title = "Xabarlar"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "primary900")
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func postChatAPI(text: String){
        let service = PostService()
        Loader.start()
        service.createChatPost(model: PostChatRequest(text: text, id: id)) { [self] result in
            switch result{
            case.success:
                Loader.stop()
                getChatAPI(page: page)
            case.failure(let error):
                print(error.message ?? "GGGGGGG")
            }
        }
    }
    
    func getChatAPI(page: Int){
        let service = PostService()
        service.getChatExpressData(model: PostGetChatRequest(page: page, id: id)) { [self] result in
            chats.removeAll()
            switch result{
            case.success(let content):
                guard let data = content.data else{return}
                guard let meta = content.meta?.total else{return}
                totalMessages = meta
                chats.append(contentsOf: data)
                tableView.reloadData()
            case.failure(let error):
                Alert.showAlert(forState: .error, message: error.message ?? "Error", vibrationType: .error)
            }
        }
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if chatTF.text! != "" {
            postChatAPI(text: chatTF.text!)
            tableView.reloadData()
            chatTF.text?.removeAll()
        }
    }
    
}

//MARK: Table View
extension ChatVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chats.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTVC.identifier, for: indexPath) as! ChatTVC
        cell.updateCell(data: chats[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == chats.count-1{
                if self.totalMessages > chats.count{
                    page += 1
                    Loader.start()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                        Loader.stop()
                        getChatAPI(page: page)
                        tableView.reloadData()
                    }
                }
            }
    }

    
}
