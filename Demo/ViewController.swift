//
//  ViewController.swift
//  Demo
//
//  Created by Rashid Latif on 08/08/2020.


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var singleCheckBoxOutlet:UIButton!{
        didSet{
            singleCheckBoxOutlet.setImage(UIImage(systemName:"checkmark.seal"), for: .normal)
            singleCheckBoxOutlet.setImage(UIImage(systemName:"checkmark.seal.fill"), for: .selected)
            //Set corner radius
            singleCheckBoxOutlet.layer.cornerRadius = singleCheckBoxOutlet.frame.height / 2
        }
    }
    
    @IBOutlet private var multiRadioButton: [UIButton]!{
        didSet{
            multiRadioButton.forEach { (button) in
                button.setImage(UIImage(named:"circle_radio_unselected"), for: .normal)
                button.setImage(UIImage(named:"circle_radio_selected"), for: .selected)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func singleCheckboxAction(_ sender: UIButton){
        sender.checkboxAnimation {
            print("I'm done")
            print(sender.isSelected)
            
        }
    }
    
    ///Create two separate actions
    /*
    @IBAction private func maleAction(_ sender: UIButton){
        uncheck()
        sender.checkboxAnimation {
            print(sender.titleLabel?.text ?? "")
            print(sender.isSelected)

        }
    }

    @IBAction private func femaleAction(_ sender: UIButton){
        uncheck()
        sender.checkboxAnimation {
            print(sender.titleLabel?.text ?? "")
            print(sender.isSelected)
        }
    }
    */
    
    //Handle with single Action
    @IBAction private func maleFemaleAction(_ sender: UIButton){
        uncheck()
        sender.checkboxAnimation {
            print(sender.titleLabel?.text ?? "")
            print(sender.isSelected)
        }
        
        // NOTE:- here you can recognize with tag weather it is `Male` or `Female`.
        print(sender.tag)
    }
    
    func uncheck(){
        multiRadioButton.forEach { (button) in
            button.isSelected = false
        }
    }
    
}

extension UIButton {
    //MARK:- Animate check mark
    func checkboxAnimation(closure: @escaping () -> Void){
        guard let image = self.imageView else {return}
        self.adjustsImageWhenHighlighted = false
        self.isHighlighted = false
        
        UIView.animate(withDuration: 0.1, delay: 0.1, options: .curveLinear, animations: {
            image.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
        }) { (success) in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.isSelected = !self.isSelected
                //to-do
                closure()
                image.transform = .identity
            }, completion: nil)
        }
        
    }
}
