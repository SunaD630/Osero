//
//  ViewController.swift
//  Osero
//
//  Created by 達巳 on 2022/05/23.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    let margin:Float = 1.0
    internal func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 8
    }
    //セクションの中のセルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    //セルのサイズを指定する処理
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // 横方向のスペース調整
        let horizontalSpace:CGFloat = 1
  
        let cellSize:CGFloat = self.view.bounds.width/8 - horizontalSpace*7
     
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(margin), left: CGFloat(margin), bottom: CGFloat(margin), right: CGFloat(margin))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(margin)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(margin)
    }
    //セルに表示する内容を記載する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //storyboard上のセルを生成
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        //セル上のTag(1)とつけたUILabelを生成
        let label = cell.contentView.viewWithTag(1) as! UILabel

        //今回は簡易的にセルの番号をラベルのテキストに反映させる
        label.text = String(indexPath.section*8 + indexPath.row + 1)

        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

