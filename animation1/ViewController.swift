//
//  ViewController.swift
//  animation1
//
//  Created by Ground 2 on 04/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    let numberOfCellsPerRow = 15
    var hashMapForCells = [String : UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = view.frame.width / CGFloat(numberOfCellsPerRow)
        let numberOfColumns = view.frame.height / width
        
        
        for j in 0...Int(numberOfColumns){
            for i in 0...numberOfCellsPerRow{
                let cellView = UIView()
                cellView.backgroundColor = .black
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width, width: width, height: width)
                cellView.layer.borderWidth = 1
                cellView.layer.borderColor = UIColor.black.cgColor
                hashMapForCells["\(i)|\(j)"] = cellView
                view.addSubview(cellView)
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    func randomColor() -> UIColor{
        let r = Float.random(in:0...1 )
        let g = Float.random(in:0...1 )
        let b = Float.random(in:0...1 )
        
        return UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1)
    }
    
    lazy var selectedCell = hashMapForCells["0|0"]
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        if gesture.state == .began{
            print("Gesture Started...")
        }
        else if gesture.state == .changed{
            let location = gesture.location(in: view)
            
            let i = Int(location.x/(view.frame.width / CGFloat(numberOfCellsPerRow)))
            let j = Int(location.y/(view.frame.width / CGFloat(numberOfCellsPerRow)))
            
            
            guard let currentCell = hashMapForCells["\(i)|\(j)"] else {return}
            
            view.bringSubviewToFront(selectedCell!)
            
            if(selectedCell != currentCell){
                UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) {
                    
                    self.selectedCell!.transform = CGAffineTransform.identity
                    self.selectedCell?.backgroundColor = .black
                }
            }
            
            selectedCell = currentCell
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) {
                
                currentCell.transform = CGAffineTransform(scaleX: 2, y: 2)
                currentCell.backgroundColor = .white
            }
        }
        else if gesture.state == .ended{
            
            selectedCell?.transform = CGAffineTransform.identity
            selectedCell?.backgroundColor = .black
            
        }
    }


}

