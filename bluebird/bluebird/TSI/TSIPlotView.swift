//
//  TSIPlotView.swift
//  bluebird
//
//  Created by macbook on 2/6/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class TSIPlotView: UIView {
    
    var plot1: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot2: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot3: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot4: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot5: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot6: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot7: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot8: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var plot9: Int = 0 { didSet { setNeedsDisplay(); setNeedsLayout() } }
    
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
        
        let verticalLineStep = (bounds.maxX - bounds.minX) / 10
        let horizontalLineStep = (bounds.maxY - bounds.minY) / 11
        let viewHeight = (bounds.maxY - bounds.minY)
        
        // drawing grid
        
        // MARK: - Scores text on plot
        
        let tScoresAttributes: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 15.0),
            .foregroundColor: UIColor.black
        ]
        
        let scoresText = ["10", "20", "30", "40", "50", "60", "70", "80"]
        var attributedScoresStringWidth = CGFloat(0) // height needed to keep for later
        
        for i in 3...10 {
            let attributedScoresString = NSAttributedString(string: scoresText[i-3], attributes: tScoresAttributes)
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
        
        let scalesText = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        var attributedScalesStringHeight = CGFloat(0) // height needed to keep for later
        
        for i in 1...9 {
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
        
        let scoreValues = [plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9]
        print("scores:\(scoreValues)")
        var attributedScoresStringHeight = CGFloat(0) // height needed to keep for later
        
        for i in 1...9 {
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
        
        for i in 1...9 {
            horizontalGridPath.move(to: CGPoint(x: bounds.minX + verticalLineStep, y: CGFloat(i) * horizontalLineStep))
            horizontalGridPath.addLine(to: CGPoint(x: bounds.maxX - verticalLineStep, y: CGFloat(i) * horizontalLineStep))
        }
        
        UIColor.lightGray.setStroke()
        horizontalGridPath.lineWidth = CGFloat(1)
        horizontalGridPath.stroke()
        
        // MARK: - Vertical grid
        
        let verticalGridPath = UIBezierPath()
        
        for i in 1...10 {
            verticalGridPath.move(to: CGPoint(x: bounds.minX + CGFloat(i) * verticalLineStep, y: viewHeight - 2*horizontalLineStep))
            verticalGridPath.addLine(to: CGPoint(x: bounds.minX + CGFloat(i) * verticalLineStep, y: 0))
        }
        
        UIColor.lightGray.setStroke()
        verticalGridPath.lineWidth = CGFloat(1)
        verticalGridPath.stroke()
        
        // MARK: - Drawing TSI plot
        
        let restPath = UIBezierPath()
        
        // 0to9
        
        for i in 1...9 {
            if i == 1 {
                restPath.move(to: CGPoint(x: bounds.minX + CGFloat(i) * verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(scoreValues[i-1]) / 80.0)) * (viewHeight - 2*horizontalLineStep)))
            } else {
                restPath.addLine(to: CGPoint(x: bounds.minX + CGFloat(i) * verticalLineStep, y: viewHeight - 2*horizontalLineStep - CGFloat((Double(scoreValues[i-1]) / 80.0)) * (viewHeight - 2*horizontalLineStep)))
            }
        }
        
        #colorLiteral(red: 0, green: 0.3430483341, blue: 0.7046421766, alpha: 1).withAlphaComponent(0.85).setStroke()
        restPath.lineWidth = CGFloat(3)
        restPath.stroke()
        
    }
}
