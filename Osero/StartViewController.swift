//
//  StartViewController.swift
//  Osero
//
//  Created by 達巳 on 2022/06/11.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "osero.jpeg")
        guard let url: URL = URL(string:"https://titleId.playfabapi.com/Authentication/GetEntityToken") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            dump(data)
            dump(response)
            dump(error)
        })
        task.resume()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
