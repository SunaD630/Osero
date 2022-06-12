//
//  FinishViewController.swift
//  Osero
//
//  Created by 達巳 on 2022/06/12.
//

import UIKit

class FinishViewController: UIViewController {
    var score:Int!
    var text:String!
    
    @IBOutlet weak var scoreText:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(score)
        if (score == 1){
            text = "WIN : Player 1!!!"
        }else if score == -1{
            text = "WIN : Player 2!!!"
        }else{
            text = "DRAW!!!"
        }
        scoreText.text = text

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
