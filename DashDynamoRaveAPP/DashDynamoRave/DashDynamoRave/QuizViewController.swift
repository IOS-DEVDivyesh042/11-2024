
import UIKit
import GameKit

@available(iOS 13.0, *)
class QuizViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    @IBOutlet weak var backtoview: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var retryBtn: UIButton!
    @IBOutlet weak var questionEmptyLabel: UILabel!
    
    var seconds = 1680
    var timer = Timer()
    
    let allQuestions = QuestionBank()
    var QuestionNo: Int = 0
    var correctAns: Int = 0
    var score: Int = 0
    var prevUsedNos: [Int] = []
    var currentQuestion: Question? = nil
    var askedQuestions: [Question]? = []
    var alreadyAsked = Set<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mind Challenge"
        loadNewQuestion()
        startAutoSwitchTimer()
        questionLabel.layer.cornerRadius = 10
    }
   
    @IBAction func buttonback(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func timerString(time: TimeInterval) -> String {
        let mins = Int(time) / 60 % 60
        let secs = Int(time) % 60
        return String(format: "%02i : %02i", mins, secs)
    }
    
    func emptyView() {
        title = ""
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        
        questionLabel.isHidden = true
        option1.isHidden = true
        option2.isHidden = true
        option3.isHidden = true
        option4.isHidden = true
        timerLabel.isHidden = true
        
        questionEmptyLabel.isHidden = false
        retryBtn.isHidden = false
    }
    
    @IBAction func retryClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "QuizBoardViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getRandomQuestion() -> [String] {
        if allQuestions.questions.isEmpty {
            emptyView()
            print("No Questions to Fetch")
            return []
        }
        
        var ans: [String] = []
        var randomNo = GKRandomSource.sharedRandom().nextInt(upperBound: allQuestions.questions.count)
        let q = allQuestions.questions[randomNo].questionTxt
        
        if !alreadyAsked.contains(q) {
            alreadyAsked.insert(q)
            ans.append(q)
            ans.append(allQuestions.questions[randomNo].optionA)
            ans.append(allQuestions.questions[randomNo].optionB)
            ans.append(allQuestions.questions[randomNo].optionC)
            ans.append(allQuestions.questions[randomNo].optionD)
            ans.append(String(allQuestions.questions[randomNo].correctAnswerIdx))
            return ans
        }
        
        repeat {
            randomNo = GKRandomSource.sharedRandom().nextInt(upperBound: allQuestions.questions.count)
        } while alreadyAsked.contains(allQuestions.questions[randomNo].questionTxt)
        
        alreadyAsked.insert(allQuestions.questions[randomNo].questionTxt)
        ans.append(allQuestions.questions[randomNo].questionTxt)
        ans.append(allQuestions.questions[randomNo].optionA)
        ans.append(allQuestions.questions[randomNo].optionB)
        ans.append(allQuestions.questions[randomNo].optionC)
        ans.append(allQuestions.questions[randomNo].optionD)
        ans.append(String(allQuestions.questions[randomNo].correctAnswerIdx))
        
        return ans
    }
    
    func resetUI() {
        option1.setTitleColor(.white, for: .normal)
        option2.setTitleColor(.white, for: .normal)
        option3.setTitleColor(.white, for: .normal)
        option4.setTitleColor(.white, for: .normal)
    }
    
    func loadNewQuestion() {
        if QuestionNo < 28 {
            resetUI()
            let questionProperties = getRandomQuestion()
            
            if questionProperties.isEmpty {
                return
            }
            
            let asked = Question(
                questionTxt: questionProperties[0],
                optionA: questionProperties[1],
                optionB: questionProperties[2],
                optionC: questionProperties[3],
                optionD: questionProperties[4],
                correctAnsIdx: Int(questionProperties[5])!,
                selectedAnsIdx: -1,
                currScore: 0
            )
            askedQuestions?.append(asked)
            currentQuestion = asked
            
            print("\(QuestionNo) : \(questionProperties[0])")
            
            self.title = "\(QuestionNo + 1) / 28"
            
            questionLabel.text = questionProperties[0]
            option1.setTitle(questionProperties[1], for: .normal)
            option2.setTitle(questionProperties[2], for: .normal)
            option3.setTitle(questionProperties[3], for: .normal)
            option4.setTitle(questionProperties[4], for: .normal)
            correctAns = Int(questionProperties[5])!
        }
    }
    
    @IBAction func option1Click(_ sender: Any) {
        handleOptionSelection(option: 1)
    }
    
    @IBAction func option2Click(_ sender: Any) {
        handleOptionSelection(option: 2)
    }
    
    @IBAction func option3Click(_ sender: Any) {
        handleOptionSelection(option: 3)
    }
    
    @IBAction func option4Click(_ sender: Any) {
        handleOptionSelection(option: 4)
    }
    
    func handleOptionSelection(option: Int) {
        askedQuestions![QuestionNo].selectedAnswerIdx = option
        currentQuestion?.selectedAnswerIdx = option
        checkAnswer(selectedOption: option)
        updateSelected()
        
        // Automatically load the next question without delay
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        if QuestionNo < 27 {
            QuestionNo += 1
            loadNewQuestion()
        } else {
            finishQuiz()
        }
    }
    
    func loadPrevQuestion() {
        if QuestionNo > 0 {
            QuestionNo -= 1
            loadNewQuestion()
        }
    }
    
    @objc func finishQuiz() {
        updateCoinsLabel()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vcToPresent = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        vcToPresent.score = score
        navigationController?.pushViewController(vcToPresent, animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let vc = segue.destination as! ResultViewController
            vc.score = score
        }
    }
    
    func updateSelected() {
        if let selectedAnswerIdx = currentQuestion?.selectedAnswerIdx {
            switch selectedAnswerIdx {
            case 1:
                option1.setTitleColor(.black, for: .normal)
                option2.setTitleColor(.systemBlue, for: .normal)
                option3.setTitleColor(.systemBlue, for: .normal)
                option4.setTitleColor(.systemBlue, for: .normal)
            case 2:
                option1.setTitleColor(.systemBlue, for: .normal)
                option2.setTitleColor(.black, for: .normal)
                option3.setTitleColor(.systemBlue, for: .normal)
                option4.setTitleColor(.systemBlue, for: .normal)
            case 3:
                option1.setTitleColor(.systemBlue, for: .normal)
                option2.setTitleColor(.systemBlue, for: .normal)
                option3.setTitleColor(.black, for: .normal)
                option4.setTitleColor(.systemBlue, for: .normal)
            case 4:
                option1.setTitleColor(.systemBlue, for: .normal)
                option2.setTitleColor(.systemBlue, for: .normal)
                option3.setTitleColor(.systemBlue, for: .normal)
                option4.setTitleColor(.black, for: .normal)
            default:
                break
            }
        }
    }
    
    func checkAnswer(selectedOption: Int) {
        if selectedOption == correctAns {
            if askedQuestions![QuestionNo].currentScore == 0 {
                askedQuestions![QuestionNo].currentScore = 1
                score += 1
            }
        } else {
            if askedQuestions![QuestionNo].currentScore > 0 {
                askedQuestions![QuestionNo].currentScore = 0
                score -= 1
            }
        }
        print("score: \(score)")
    }
    
    func startAutoSwitchTimer() {
        guard timerLabel != nil else {
            print("Error: timerLabel is nil")
            return
        }

        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            self.seconds -= 1
            self.timerLabel.text = self.timerString(time: TimeInterval(self.seconds))
            
            if self.seconds == 0 {
                self.finishQuiz()
            }
        }
    }
    
    func updateCoinsLabel() {
        let points = score * 50
        var coins = UserDefaults.standard.integer(forKey: "userCoins")
        coins += points
        UserDefaults.standard.set(coins, forKey: "userCoins")
    }
}
