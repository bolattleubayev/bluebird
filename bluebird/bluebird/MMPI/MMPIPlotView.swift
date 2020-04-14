//
//  MMPIPlotView.swift
//  bluebird
//
//  Created by macbook on 1/26/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//


import UIKit

class MMPIPlotView: UIView {
    
    var isMale = true
    var plotL: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plotF: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plotK: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot1: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot2: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot3: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot4: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot5: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot6: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot7: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot8: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot9: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot0: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let backgroundRect = UIBezierPath(roundedRect: bounds, cornerRadius: 0)
        if #available(iOS 13.0, *) {
            UIColor.systemBackground.setFill()
        } else {
            // Fallback on earlier versions
            #colorLiteral(red: 0.967885637, green: 0.9774686631, blue: 0.9774686631, alpha: 1).setFill()
        }
        backgroundRect.fill()
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        
        #colorLiteral(red: 0.967885637, green: 0.9774686631, blue: 0.9774686631, alpha: 1).setFill()
        roundedRect.fill()
        
        let verticalLineStep = (bounds.maxX - bounds.minX) / 14
        let horizontalLineStep = (bounds.maxY - bounds.minY) / 14
        let viewHeight = (bounds.maxY - bounds.minY)
        
        // drawing grid
        
        // MARK: - T-scores text on plot
        
        let tScoresAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 15.0),
            .foregroundColor: UIColor.black
        ]
        
        let scoresText = ["10", "20", "30", "40", "50", "60", "70", "80", "90", "100", "110"]
        var attributedScoresStringWidth = CGFloat(0) // height needed to keep for later
        
        for i in 3...13 {
            let attributedScoresString = NSAttributedString(string: scoresText[i - 3], attributes: tScoresAttributes)
            attributedScoresStringWidth = attributedScoresString.size().width
            let stringRectLeft = CGRect(x: bounds.minX,
                                    y: bounds.maxY - CGFloat(i) * horizontalLineStep - attributedScoresString.size().height / 2,
                                    width: attributedScoresString.size().width,
                                    height: attributedScoresString.size().height)
            attributedScoresString.draw(in: stringRectLeft)
            
            let stringRectRight = CGRect(x: bounds.maxX - verticalLineStep + 2,
                                    y: bounds.maxY - CGFloat(i) * horizontalLineStep - CGFloat(2) * attributedScoresString.size().height / 2,
                                    width: attributedScoresString.size().width,
                                    height: attributedScoresString.size().height)
            attributedScoresString.draw(in: stringRectRight)
        }
        
        // MARK: - Scales text on plot
        
        let scalesAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 20.0),
            .foregroundColor: UIColor.black
        ]
        
        var scalesText = [""]
        if isMale {
            scalesText = ["L", "F", "K", "1", "2", "3", "4", "5М", "6", "7", "8", "9", "0"]
        } else {
            scalesText = ["L", "F", "K", "1", "2", "3", "4", "5Ж", "6", "7", "8", "9", "0"]
        }
        
        var attributedScalesStringHeight = CGFloat(0) // height needed to keep for later
        
        for i in 1...13 {
            let attributedScalesString = NSAttributedString(string: scalesText[i - 1], attributes: scalesAttributes)
            attributedScalesStringHeight = attributedScalesString.size().height
            let stringRect = CGRect(x: bounds.minX + CGFloat(i)
                * verticalLineStep - attributedScalesString.size().width / 2,
                                    y: bounds.maxY - 2*horizontalLineStep,
                                    width: attributedScalesString.size().width,
                                    height: attributedScalesString.size().height)
            attributedScalesString.draw(in: stringRect)
        }
        
        // MARK: - Score values on plot
        
        let scoresAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 15.0),
            .foregroundColor: UIColor.black
        ]
        
        let scoreValues = [plotL, plotF, plotK, plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, plot0]
        var attributedScoresStringHeight = CGFloat(0) // height needed to keep for later
        
        for i in 1...13 {
            let attributedScoresString = NSAttributedString(string: String(scoreValues[i - 1]), attributes: scoresAttributes)
            attributedScoresStringHeight = attributedScoresString.size().height
            let stringRect = CGRect(x: bounds.minX + CGFloat(i)
                * verticalLineStep - attributedScoresString.size().width / 2,
                                    y: bounds.maxY - horizontalLineStep,
                                    width: attributedScoresString.size().width,
                                    height: attributedScoresString.size().height)
            attributedScoresString.draw(in: stringRect)
        }
        
        // MARK: - Horizontal grid
        
        let horizontalGridPath = UIBezierPath()
        
        for i in 1...11 {
            horizontalGridPath.move(to: CGPoint(x: bounds.minX + verticalLineStep, y: CGFloat(i) * horizontalLineStep))
            horizontalGridPath.addLine(to: CGPoint(x: bounds.maxX - verticalLineStep, y: CGFloat(i) * horizontalLineStep))
        }
        
        UIColor.lightGray.setStroke()
        horizontalGridPath.lineWidth = CGFloat(1)
        horizontalGridPath.stroke()
        
        // MARK: - Vertical grid
        
        let verticalGridPath = UIBezierPath()
        
        for i in 1...13 {
            verticalGridPath.move(to: CGPoint(x: bounds.minX + CGFloat(i) * verticalLineStep, y: viewHeight - 2*horizontalLineStep))
            verticalGridPath.addLine(to: CGPoint(x: bounds.minX + CGFloat(i) * verticalLineStep, y: 0))
        }
        
        UIColor.lightGray.setStroke()
        verticalGridPath.lineWidth = CGFloat(1)
        verticalGridPath.stroke()
        
        // MARK: - Isoline
        
        let isolineValue = scoreValues[3...12]
        
        var isolineSum = 0
        
        for isoVal in isolineValue {
            isolineSum += isoVal
        }
        
        let isolinePath = UIBezierPath()
        
        isolinePath.move(to: CGPoint(x: bounds.minX + CGFloat(4) * verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(isolineSum / isolineValue.count) / 120.0)) * (viewHeight - 2*horizontalLineStep)))
        
        isolinePath.addLine(to: CGPoint(x: bounds.maxX - verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(isolineSum / isolineValue.count) / 120.0)) * (viewHeight - 2*horizontalLineStep)))
        
        #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).withAlphaComponent(0.85).setStroke()
        isolinePath.lineWidth = CGFloat(3)
        isolinePath.stroke()
        
        // MARK: - Normal Window Lines
        
        let normalPath = UIBezierPath()
        
        normalPath.move(to: CGPoint(x: bounds.minX + verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(70) / 120.0)) * (viewHeight - 2*horizontalLineStep)))
        
        normalPath.addLine(to: CGPoint(x: bounds.maxX - verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(70) / 120.0)) * (viewHeight - 2*horizontalLineStep)))
        
        normalPath.move(to: CGPoint(x: bounds.minX + verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(30) / 120.0)) * (viewHeight - 2*horizontalLineStep)))
        
        normalPath.addLine(to: CGPoint(x: bounds.maxX - verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(30) / 120.0)) * (viewHeight - 2*horizontalLineStep)))
        
        #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1).setStroke()
        normalPath.lineWidth = CGFloat(3)
        normalPath.stroke()
        
        // MARK: - Drawing MMPI plot
        let lfkPath = UIBezierPath()
        
        // LFK
        
        for i in 1...3 {
            if i == 1 {
                lfkPath.move(to: CGPoint(x: bounds.minX + CGFloat(i) * verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(scoreValues[i-1]) / 120.0)) * (viewHeight - 2*horizontalLineStep)))
            } else {
                lfkPath.addLine(to: CGPoint(x: bounds.minX + CGFloat(i) * verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(scoreValues[i-1]) / 120.0)) * (viewHeight - 2*horizontalLineStep)))
            }
        }
        
        #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).setStroke()
        lfkPath.lineWidth = CGFloat(3)
        lfkPath.stroke()
        
        let restPath = UIBezierPath()
        
        // 0to9
        
        for i in 4...13 {
            if i == 4 {
                restPath.move(to: CGPoint(x: bounds.minX + CGFloat(i) * verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(scoreValues[i-1]) / 120.0)) * (viewHeight - 2*horizontalLineStep)))
            } else {
                restPath.addLine(to: CGPoint(x: bounds.minX + CGFloat(i) * verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(scoreValues[i-1]) / 120.0)) * (viewHeight - 2*horizontalLineStep)))
            }
        }
        
        #colorLiteral(red: 0, green: 0.3430483341, blue: 0.7046421766, alpha: 1).withAlphaComponent(0.85).setStroke()
        restPath.lineWidth = CGFloat(3)
        restPath.stroke()
        
    }
    
}
