//
//  ViewController.swift
//  scrollViewTest
//
//  Created by Cara Brennan on 9/14/18.
//  Copyright © 2018 Cara Brennan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    lazy var channelArray: [Channel] = {
        let dataSource = DataSource().json
        var array: [Channel] = []
        for index in 0..<dataSource.count {
            array.append(Channel(jsonImport: dataSource[index])!)
        }
        return array
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let layout = emojiCollectionView?.collectionViewLayout as? CollectionViewLayout {
            layout.delegate = self
        }

    }

    @IBOutlet weak var emojiCollectionView: UICollectionView! {
        didSet {

            emojiCollectionView.dataSource = self
            emojiCollectionView.delegate = self
        }

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("calling numberofitmes", channelArray[section].programs.count)
        return channelArray[section].programs.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {

        print (channelArray.count, "sections")
        return channelArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        //also have to specify what channel
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath)

        if let emojiCell = cell as? EmojiCollectionViewCell {
//            let text = NSAttributedString(string: Channel[indexPath.item])
            let text = NSAttributedString(string: channelArray[indexPath.section].programs[indexPath.item].title)
            print(indexPath.section, "section")
            print(indexPath.row, "row")
            emojiCell.label.attributedText = text
        }
        return cell

    }

}


extension ViewController: CollectionViewLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        widthForCellAtIndexPath indexPath:IndexPath) -> CGFloat {
            let length = channelArray[indexPath.section].programs[indexPath.item].programLength

            let width = length * 75
            let widthFloat = CGFloat(width)

        return widthFloat
        
    }

}

