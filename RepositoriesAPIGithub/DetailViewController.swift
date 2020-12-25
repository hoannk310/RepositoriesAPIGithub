//
//  DetailViewController.swift
//  RepositoriesAPIGithub
//
//  Created by Apple on 10/2/1942 Saka.
//

import UIKit
import Alamofire
import AlamofireImage
class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var detailTbView: UITableView!
    var branchs = [Branch]()
    var nameRepo: String?
    var authorRepo: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTbView.delegate = self
        detailTbView.dataSource = self
        // Do any additional setup after loading the view.
        print(nameRepo, " ", authorRepo)
        AF.request("https://api.github.com/repos/\(authorRepo!)/\(nameRepo!)/branches", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            print(responseData.data)
            guard let data = responseData.data else{return}
            do {
                let repo = try JSONDecoder().decode([Branch].self, from: data)

                self.branchs = repo
                self.detailTbView.reloadData()
            }catch{

            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return branchs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell{
            cell.lblBranch.text = branchs[indexPath.row].name
            cell.lblType.text = "\(branchs[indexPath.row].protected)"
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

