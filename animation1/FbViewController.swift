//
//  FbViewController.swift
//  animation1
//
//  Created by Ground 2 on 19/04/24.
//

import UIKit

class FbViewController: UIViewController {
    
    let iconSize = 25
    
    var reactionView : UIView = {
       let view = UIStackView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.5
        view.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        view.isLayoutMarginsRelativeArrangement = true
        view.frame = CGRect(x: 0, y: 0, width: CGFloat((25 * 6) + (5 * 5) + 50), height: CGFloat(25 + 16))
        view.layer.cornerRadius = view.frame.height / 2
        
        let image1 = UIImageView(image: .nice)
        let image2 = UIImageView(image: .heart)
        let image3 = UIImageView(image: .haha)
        let image4 = UIImageView(image: .wow)
        let image5 = UIImageView(image: .sad)
        let image6 = UIImageView(image: .angry)
                                                
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        
        view.addArrangedSubview(image1)
        view.addArrangedSubview(image2)
        view.addArrangedSubview(image3)
        view.addArrangedSubview(image4)
        view.addArrangedSubview(image5)
        view.addArrangedSubview(image6)
        
        
        view.spacing = 5
        view.distribution = .fillEqually
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    
    @objc func handleTap(_ gesture: UILongPressGestureRecognizer){
        let location = gesture.location(in: view)
        
        if gesture.state == .began{
            
            reactionView.transform = CGAffineTransform(translationX: location.x, y: location.y)
            view.addSubview(reactionView)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) {
                self.reactionView.layer.opacity = 1
                self.reactionView.transform = CGAffineTransform(translationX: location.x, y: location.y - CGFloat(self.iconSize + 10))
            }
            
            
        }
        if gesture.state == .changed{
            let location = gesture.location(in: reactionView)
            
            let currentView = self.reactionView.hitTest(CGPoint(x: location.x, y: reactionView.frame.height / 2), with: nil)
            
            if currentView is UIImageView{
                
                
                
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) {
                    
                    
                    self.reactionView.subviews.forEach({ i in
                        i.transform = .identity
                    })
                    
                    currentView?.transform = CGAffineTransform(translationX: 0, y: -50)
                }
            }
            
        }
        
        if gesture.state == .ended{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) {
                self.reactionView.subviews.forEach({ i in
                    i.transform = .identity
                })
                self.reactionView.layer.opacity = 0
                self.reactionView.transform = CGAffineTransform(translationX: self.reactionView.frame.minX, y: self.reactionView.frame.minY + CGFloat(self.iconSize) - 10)
            } completion: { success in
                self.reactionView.removeFromSuperview()
            }

            
        }
    }
    

}
