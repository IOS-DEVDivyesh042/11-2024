

import UIKit

@available(iOS 13.0, *)
class ResultViewController: UIViewController {

    var score = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!

    @IBOutlet weak var LBLstaticscore: UILabel!
    
    @IBOutlet weak var btnhomeesssc: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(score) / 28"
        setFeedback()
        print("final score : \(score)")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    callinit()
       
    }
    
    func callinit(){
        btnhomeesssc.layer.cornerRadius = 10
        LBLstaticscore.layer.cornerRadius = 10
        feedbackLabel.layer.cornerRadius = 10
        
    }
    
  
    
    @IBAction func retryClick(_ sender: Any) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "QuizBoardViewController")
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func backbtt(_ sender: Any) {
        if let navigationController = self.navigationController {
                navigationController.popToRootViewController(animated: true)
            }

    }
    
    func setFeedback() {
        if(score >= 8) {
            feedbackLabel.text = "You succeeded!"
        }
        else if(score >= 4 ){
            feedbackLabel.text = "Aim Higher!"
        }
        else {
            feedbackLabel.text = "Never succumb!"
        }
    }
    
}
