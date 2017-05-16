//
//  ViewController.swift
//  JsonDataInTableView
//
//  Created by Bansi Bhatt on 16/05/17.
//
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var arrData = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Fetch Data
    func fetchData(){
        let url = URL(string :"http://ip.jsontest.com/")
       
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
            print("Error found like \(error)")
            }
            if data != nil{
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
                 
                    if ((jsonData?.count)! >= 1) {
                        print("json data \(jsonData)")
                        let value = jsonData?["ip"]
                        self.arrData.append(value as! String)
                        self.tableView.reloadData()
                    }
                    
                } catch  {
                    print("catch an exception \(error)")
                }
            }
        }
        task.resume()
       
        
    }
    
    //MARK:- UITableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (arrData.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = arrData[indexPath.row]
        return cell!
    }

}

