//
//  ViewController.swift
//  RepositoriesAPIGithub
//
//  Created by Apple on 9/30/1942 Saka.
//

import UIKit
import Alamofire
import AlamofireImage
class ViewController: UIViewController,UISearchBarDelegate {
    var pageSearch = 1
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchRepos: UISearchBar!
    @IBOutlet weak var reposTableView: UITableView!
   
    var searchs = [SearchRepo]()
    var repos = [Repository]()
    var author = [String : Any]()
    var recordArray = Int()
    var limit = 15
    var totalEnteries = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        reposTableView.delegate = self
        reposTableView.dataSource = self
        searchRepos.delegate = self
       
        AF.request("https://api.github.com/repositories", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
            print(responseData.data)
            guard let data = responseData.data else{return}
            do {
                let repo = try JSONDecoder().decode([Repository].self, from: data)

                self.repos = repo
                self.recordArray = self.repos.count
                self.reposTableView.reloadData()
            }catch{

            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("")
        if searchText.isEmpty {
            AF.request("https://api.github.com/repositories", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
                print(responseData.data)
                guard let data = responseData.data else{return}
                do {
                    let repo = try JSONDecoder().decode([Repository].self, from: data)

                    self.repos = repo
                    self.recordArray = self.repos.count
                    self.reposTableView.reloadData()
                }catch{

                }
            }
        } else{
            let queue = DispatchQueue(label: "search")
            queue.asyncAfter(deadline: DispatchTime.now()+1) {
                AF.request("https://api.github.com/search/repositories?q=\(searchText)&sort=stars&order=desc&page=\(self.pageSearch)", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { (responseData) in
                    print(responseData)
                    print(searchText)
                    
                    guard let data = responseData.data else{return}
                    do {
                        print("data")
                        let reposi = try JSONDecoder().decode(SearchRepo.self, from: data)
                        if(reposi.items != nil){
                        self.repos = reposi.items!
                        self.recordArray = 15
                        self.totalEnteries = self.repos.count
                        DispatchQueue.main.async {
                            self.reposTableView.reloadData()
                        }
                            
                        }
                        
                    }catch{
                        print("catch")
                    }
                }
            }
          
            
        }
//        AF.request("https://api.github.com/search/repositories?q=chat&sort=stars&order=desc&page=1").responseJSON { (response) in
//            if let responseValue = response.value as! [String:Any]? {
//                if let reposi = responseValue["items"] as? [[String:Any]] {
//                  r
//                }
//
//
//                self.reposTableView.reloadData()
//            }
//        }
    }
 

}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordArray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoriesTableViewCell{
            cell.lblNameRepos.text = repos[indexPath.row].name
            cell.lblAuthor.text = repos[indexPath.row].owners?.login
            if let imgURL = repos[indexPath.row].owners?.avatar!{
                AF.request(imgURL).responseImage { (response) in
                    if let img = response.value{
                        DispatchQueue.main.async {
                            cell.imgAuthor.image = img
                        }
                        
                    }
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "detail") as! DetailViewController
        vc.nameRepo = repos[indexPath.row].name
        vc.authorRepo = repos[indexPath.row].owners?.login
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == recordArray - 1 {
            if recordArray < totalEnteries{
                var index = recordArray
                limit = index + 15
                while index < limit {
                    recordArray += 1
                    index += 1
                }
                self.perform(#selector(loadMore), with: nil,afterDelay: 1.0)
                DispatchQueue.main.async {
                    
                    self.activityIndicator.startAnimating()
                }
            }
            else{
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }
    @objc func loadMore() {
       
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            self.reposTableView.reloadData()
        }
    }
    
}

