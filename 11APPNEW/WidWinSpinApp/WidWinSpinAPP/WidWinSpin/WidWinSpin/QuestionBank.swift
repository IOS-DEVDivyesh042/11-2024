import Foundation

class QuestionBank {
    
    var questions = [Question]()
    
    init() {
        questions.append(Question(questionTxt: "Derivative of x²?", optionA: "2x", optionB: "x²", optionC: "2", optionD: "x", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Integral of 1/x?", optionA: "ln|x|", optionB: "x", optionC: "1/x", optionD: "e^x", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Value of π?", optionA: "3.14", optionB: "3.16", optionC: "3.12", optionD: "3.18", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "7 + 5 × 2?", optionA: "24", optionB: "17", optionC: "12", optionD: "10", correctAnsIdx: 1, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "√144?", optionA: "10", optionB: "12", optionC: "14", optionD: "16", correctAnsIdx: 1, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Value of 2³?", optionA: "6", optionB: "8", optionC: "4", optionD: "2", correctAnsIdx: 1, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Area of circle?", optionA: "πr²", optionB: "2πr", optionC: "r²", optionD: "πd", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "sin(90°)?", optionA: "0", optionB: "1", optionC: "0.5", optionD: "-1", correctAnsIdx: 1, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Pythagorean theorem?", optionA: "a² + b²", optionB: "a + b", optionC: "a² - b²", optionD: "a + b²", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "15% of 200?", optionA: "25", optionB: "30", optionC: "15", optionD: "20", correctAnsIdx: 1, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "10!?", optionA: "3628800", optionB: "1000", optionC: "720", optionD: "40320", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Quadratic formula?", optionA: "-b ± √(b²)", optionB: "-b / 2a", optionC: "b ± √(b²)", optionD: "a + b", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Sum of triangle angles?", optionA: "180°", optionB: "360°", optionC: "90°", optionD: "270°", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Slope-intercept form?", optionA: "y = mx + b", optionB: "y = ax²", optionC: "y = mx²", optionD: "y = mx - b", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "(3 + 5) × 2?", optionA: "16", optionB: "12", optionC: "14", optionD: "10", correctAnsIdx: 1, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Next prime after 7?", optionA: "9", optionB: "10", optionC: "11", optionD: "12", correctAnsIdx: 2, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Equation of circle?", optionA: "x² + y²", optionB: "x² + y² = r²", optionC: "x + y = r", optionD: "xy = r²", correctAnsIdx: 1, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "GCD of 8 and 12?", optionA: "4", optionB: "6", optionC: "2", optionD: "8", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "log10(100)?", optionA: "1", optionB: "2", optionC: "3", optionD: "0", correctAnsIdx: 1, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Circumference?", optionA: "2πr", optionB: "πr²", optionC: "r²", optionD: "3.14d", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Area of triangle?", optionA: "1/2 × b × h", optionB: "b + h", optionC: "b × h", optionD: "1/2 × b + h", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "If a=5, b=3, a² + b²?", optionA: "34", optionB: "25", optionC: "16", optionD: "8", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Sum of first 5 primes?", optionA: "28", optionB: "20", optionC: "15", optionD: "10", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "100 ÷ 4?", optionA: "25", optionB: "20", optionC: "30", optionD: "40", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Hypotenuse of 3, 4?", optionA: "5", optionB: "6", optionC: "7", optionD: "8", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Area of rectangle 10, 5?", optionA: "50", optionB: "60", optionC: "40", optionD: "70", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Volume of sphere?", optionA: "4/3πr³", optionB: "πr²h", optionC: "2πr²", optionD: "3πr²", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "If x=2, 3x + 4?", optionA: "10", optionB: "12", optionC: "8", optionD: "6", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "25% of 60?", optionA: "15", optionB: "12", optionC: "20", optionD: "18", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Smallest prime?", optionA: "1", optionB: "2", optionC: "3", optionD: "5", correctAnsIdx: 1, selectedAnsIdx: -1, currScore: 0))
        
        questions.append(Question(questionTxt: "Perimeter of rectangle?", optionA: "2(l + w)", optionB: "lw", optionC: "l + w", optionD: "2l + 2w", correctAnsIdx: 0, selectedAnsIdx: -1, currScore: 0))
    }
}
