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
    var stone = 1
    
    func reverse(x:Int, y:Int, board: [[Int]]){
        for i in -1..<2{
            for j in -1..<2{
                if i == 0 && j == 0{break}
                var dist:Int = 1
                while (0<=x+i*dist && x+i*dist<boardsize && 0<=y+j*dist && y+j*dist<boardsize){
                    if board[y+j*dist][x+i*dist] == stone{break}
                    dist += 1
                }
                if (dist==1 || 0>x+i*dist || x+i*dist>=boardsize || 0>y+j*dist || y+j*dist>=boardsize){
                    for k in 0..<dist{
                        board[y+j*k][x+i*k] = stone
                    }
                    stone *= -1
                }
            }
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
        let label = cell.contentView.viewWithTag(1) as! UILabel

        switch board[indexPath.section][indexPath.row]{
        case 1:
            label.text = "o"
        case -1:
            label.text = "・"
        default:
            label.text = ""
        }

        return cell
    }
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView,
                              didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        let label = cell.contentView.viewWithTag(1) as! UILabel
        
        label.text = "o"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

