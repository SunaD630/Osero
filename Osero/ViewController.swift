//
//  ViewController.swift
//  Osero
//
//  Created by 達巳 on 2022/05/23.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //セクションの中のセルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    //セルのサイズを指定する処理
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // 横方向のスペース調整
        let horizontalSpace:CGFloat = 2

        //セルのサイズを指定。画面上にセルを3つ表示させたいのであれば、デバイスの横幅を3分割した横幅　- セル間のスペース*2（セル間のスペースが二つあるため）
        let cellSize:CGFloat = self.view.bounds.width/8 - horizontalSpace*7

        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    //セルに表示する内容を記載する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //storyboard上のセルを生成
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        //セル上のTag(1)とつけたUILabelを生成
        let label = cell.contentView.viewWithTag(1) as! UILabel

        //今回は簡易的にセルの番号をラベルのテキストに反映させる
        label.text = String(indexPath.row + 1)

        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

