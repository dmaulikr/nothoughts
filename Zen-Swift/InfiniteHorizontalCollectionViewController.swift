//
//  InfiniteHorizontalCollectionViewController.swift
//  Zen-Swift
//
//  Created by Ricardo Nazario on 1/12/17.
//  Copyright © 2017 Ricardo Nazario. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class InfiniteHorizontalCollectionViewController: UICollectionViewController {
    
    var initialOffset: CGFloat = CGFloat()
    var lastOffset: CGFloat = CGFloat()
    var cellWidth: CGFloat = 120.0
    var pathArray: Array <String>! = ["Right View", "Right Thinking", "Right Mindfulness", "Right Speech", "Right Action", "Right Diligence", "Right Concentration", "Right Livelihood"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        self.collectionView!.showsHorizontalScrollIndicator = true
        initialOffset = (self.collectionView?.contentOffset.x)!
        self.collectionView?.indicatorStyle = .black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView!.scrollToItem(at: IndexPath.init(item: 4, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.lastOffset = (self.collectionView?.contentOffset.x)!
        
        if self.lastOffset - self.initialOffset > self.cellWidth {
            print("Add cell at right")
            self.initialOffset = self.lastOffset
        } else if self.initialOffset - self.lastOffset > self.cellWidth {
            print("Add cell at left")
            self.initialOffset = self.lastOffset
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print("Did end dragging")
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("Did end decelerating")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pathArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        // Configure the cell
        cell.bounds.size.height = (self.collectionView?.bounds.size.height)!
        cell.bounds.size.width = cell.bounds.size.height
        cell.backgroundColor = #colorLiteral(red: 0, green: 0.8980433345, blue: 0.8181681037, alpha: 1)
        cell.titleLabel.text = pathArray[indexPath.row]
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
