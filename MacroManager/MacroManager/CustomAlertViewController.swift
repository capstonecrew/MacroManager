//
//  CustomAlertViewController.swift
//  AlertViewTest
//
//  Created by Aaron Edwards on 2/23/17.
//  Copyright © 2017 Aaron Edwards. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {

    
    @IBOutlet weak var checkmarkBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var alertView: UIView!
    
    var circleLayer: CAShapeLayer!
    var added: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        alertView.layer.cornerRadius = 10
        checkmarkBtn.layer.cornerRadius = checkmarkBtn.bounds.size.width/2

        let timer = Timer(timeInterval: 1.0, target: self, selector: #selector(self.dismissAlert), userInfo: nil, repeats: false)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        
        if self.added == true{
            self.titleLbl.text = "Added Favorite!"
            self.checkmarkBtn.setImage(UIImage(named: "checkmark"), for: .normal)
        }else{
            self.titleLbl.text = "Removed Favorite!"
            self.checkmarkBtn.setImage(UIImage(named: "removed"), for: .normal)
        }

    }
    
//    func animateCheckmarkBtn(){
//    
//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        
//        // Set the animation duration appropriately
//        animation.duration = 5.0
//        
//        // Animate from 0 (no circle) to 1 (full circle)
//        animation.fromValue = 0
//        animation.toValue = 1
//        
//        // Do a linear animation (i.e. the speed of the animation stays the same)
//        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
//        
//        // Set the circleLayer's strokeEnd property to 1.0 now so that it's the
//        // right value when the animation ends.
//        circleLayer.strokeEnd = 1.0
//        
//        // Do the actual animation
//        circleLayer.add(animation, forKey: "animateCircle")
//    }
    
    func dismissAlert(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
