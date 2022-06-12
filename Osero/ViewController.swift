//
//  ViewController.swift
//  Osero
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let boardsize:Int = 8
    let margin:Float = 1.0
    var board:[[Int]] = [[0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0],
                          [0,0,0,-1,1,0,0,0],
                          [0,0,0,1,-1,0,0,0],
                          [0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0],
                          [0,0,0,0,0,0,0,0]]
    var prev_board:[[Int]] = [[0,0,0,0,0,0,0,0],
                              [0,0,0,0,0,0,0,0],
                              [0,0,0,0,0,0,0,0],
                              [0,0,0,-1,1,0,0,0],
                              [0,0,0,1,-1,0,0,0],
                              [0,0,0,0,0,0,0,0],
                              [0,0,0,0,0,0,0,0],
                              [0,0,0,0,0,0,0,0]]
    var stone = 1
    var finishScore:Int!
    
    @IBOutlet weak var enemyScore:UILabel!
    @IBOutlet weak var myScore:UILabel!
    @IBAction func pass(){
        stone *= -1
    }
    @IBAction func redo(){
        if board != prev_board{
            board = prev_board
            stone *= -1
        }
        
        loadView()
        viewDidLoad()
    }
    //リバース
    func reverse(x:Int, y:Int, board: [[Int]])->Int{
        var judge:Int = 0 //リバースがあったら1
        for i in -1..<2{
            for j in -1..<2{
                if i == 0 && j == 0{continue}//石を置いた位置は調べなくてもいい
                if (0<=x+i && x+i<boardsize && 0<=y+j && y+j<boardsize && board[y+j][x+i] == 0){continue}//隣が何もなければ挟めない
                var dist:Int = 1
                while (0<=x+i*dist && x+i*dist<boardsize && 0<=y+j*dist && y+j*dist<boardsize && board[y+j*dist][x+i*dist] == stone*(-1)){
                    if board[y+j*dist][x+i*dist] == stone{break}
                    dist += 1
                }
                
                print(i,j,dist,stone)
                if (dist != 1 && 0 <= x+i*dist && x+i*dist < boardsize && 0 <= y+j*dist && y+j*dist < boardsize && board[y+j*dist][x+i*dist] != 0){
                    //print(x+i*dist,y+j*dist)
                    judge = 1
                    for k in 0..<dist{
                        self.board[y+j*k][x+i*k] = stone
                    }
                }
            }
        }
        return judge
    }
    
    //count
    func countStone(board: [[Int]], stone: Int) -> Int{
        var count:Int = 0
        for i in 0..<boardsize{
            for j in 0..<boardsize{
                if (self.board[j][i] == stone){
                    count += 1
                }
            }
        }
        return count
    }
    
    //finish
    func gameFinish(board: [[Int]]) -> Int{
        var black:Int = 0
        var white:Int = 0
        for i in 0..<boardsize{
            for j in 0..<boardsize{
                if board[j][i] == 1{
                    white += 1
                }
                if board[j][i] == -1{
                    black += 1
                }
                if board[j][i] == 0{//not finish yet
                    return 0
                }
            }
        }
        if white>black{//white win
            return 1
        }else if black>white{//black win
            return -1
        }else{//draw
            return 2
        }
    }
    
    
    //セクションの数
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
            return boardsize
    }
    //セクションの中のセルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardsize
    }
    //セルのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // 横方向のスペース調整
        let horizontalSpace:CGFloat = 1
  
        let cellSize:CGFloat = self.view.bounds.width/8 - horizontalSpace*7
     
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    //セクション間のmargin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(margin), left: CGFloat(margin), bottom: CGFloat(margin), right: CGFloat(margin))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(margin)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(margin)
    }
    
    //セルの内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        //セル上のTag(1)とつけたUILabelを生成
        //let label = cell.contentView.viewWithTag(1) as! UILabel
        let imageView = cell.contentView.viewWithTag(2) as! UIImageView
        switch board[indexPath.section][indexPath.row]{
        case 1:
            imageView.image = UIImage(named: "white")
        case -1:
            imageView.image = UIImage(named: "black")
        default:
            imageView.image = UIImage(named: "background")
        }

        return cell
    }
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView,
                              didSelectItemAt indexPath: IndexPath) {
        prev_board = board
        var rev_judge = 0
        rev_judge = reverse(x: indexPath.row,y: indexPath.section,board: board)
        if rev_judge == 1{
            stone *= -1
        }
        enemyScore.text = "Player 2:  " + String(countStone(board: board, stone: -1))
        myScore.text = "Player 1:  " + String(countStone(board: board, stone: 1))
        if countStone(board: board, stone: 1) == 0 || (countStone(board: board, stone: -1) == 0){
            if countStone(board: board, stone: 1) == 0{finishScore = -1}
            if countStone(board:board, stone: -1) == 0{finishScore = 1}
            let finishView = storyboard?.instantiateViewController(withIdentifier: "FinishViewController") as! FinishViewController
            finishView.modalPresentationStyle = .fullScreen
            finishView.score = finishScore
            self.present(finishView, animated: true, completion: nil)
        }
        collectionView.reloadData()
        finishScore = gameFinish(board: board)
        if finishScore != 0{
            let finishView = storyboard?.instantiateViewController(withIdentifier: "FinishViewController") as! FinishViewController
            finishView.modalPresentationStyle = .fullScreen
            finishView.score = finishScore
            self.present(finishView, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        enemyScore.text = "Player 2:  " + String(countStone(board: board, stone: -1))
        myScore.text = "Player 1:  " + String(countStone(board: board, stone: 1))
    }


}

