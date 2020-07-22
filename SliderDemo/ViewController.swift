//
//  ViewController.swift
//  SliderDemo
//
//  Created by Jay Lin on 2020/7/19.
//  Copyright © 2020 Jay Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    //漸層view
    @IBOutlet weak var clothGradualView: UIView!
    @IBOutlet weak var rightHandGradualView: UIView!
    @IBOutlet weak var leftHandGradualView: UIView!
    @IBOutlet weak var leftWristGradualView: UIView!
    
    //衣服Slider
    @IBOutlet weak var clothRedSlider: UISlider!
    @IBOutlet weak var clothGreenSlider: UISlider!
    @IBOutlet weak var clothBlueSlider: UISlider!
    @IBOutlet weak var clothAlphaSlider: UISlider!
    
    //衣服數值
    @IBOutlet weak var clothRedLabel: UILabel!
    @IBOutlet weak var clothGreenLabel: UILabel!
    @IBOutlet weak var clothBlueLabel: UILabel!
    @IBOutlet weak var clothAlphaLabel: UILabel!
    
    //手套Slider
    @IBOutlet weak var handRedSlider: UISlider!
    @IBOutlet weak var handGreenSlider: UISlider!
    @IBOutlet weak var handBlueSlider: UISlider!
    @IBOutlet weak var handAlphaSlider: UISlider!
    
    //手套數值
    @IBOutlet weak var handRedLabel: UILabel!
    @IBOutlet weak var handGreenLabel: UILabel!
    @IBOutlet weak var handBlueLabel: UILabel!
    @IBOutlet weak var handAlphaLabel: UILabel!
    
    //漸層開關
    @IBOutlet weak var gradualSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //所有調色相關Action
    @IBAction func allColorSliderChange(_ sender: UISlider) {
        
        //判斷漸層開關作動
        if gradualSwitch.isOn {
            
            //漸層調色
            gradualViewChange()
        } else {
            //調色
            colorViewChange()
        }
        //顯示數值
        sliderTextLabel()
    }
    
    //關閉AlphaSliderSwitch
    @IBAction func gradualColorChangeSw(_ sender: UISwitch) {
        
        if gradualSwitch.isOn {
            
            //關閉AlphaSlider(因為漸層用不到)
            clothAlphaSlider.value = 1
            clothAlphaLabel.text = "1"
            clothAlphaSlider.isEnabled = false
            handAlphaSlider.value = 1
            handAlphaLabel.text = "1"
            handAlphaSlider.isEnabled = false
            
            //顯示漸層顏色
            gradualViewChange()
            
        } else {
            
            //開啟AlphaSlider
            clothAlphaSlider.isEnabled = true
            handAlphaSlider.isEnabled = true

            //關閉開關刪除漸層layer
            clothGradualView.layer.sublayers?.removeAll()
            rightHandGradualView.layer.sublayers?.removeAll()
            leftHandGradualView.layer.sublayers?.removeAll()
            leftWristGradualView.layer.sublayers?.removeAll()
            
            //關閉開關恢復所有顏色
            colorViewChange()
        }
    }
    
    //隨機顏色
    @IBAction func randomColorBtn(_ sender: UIButton) {
        
        clothRedSlider.value = Float.random(in: 0...255)
        clothGreenSlider.value = Float.random(in: 0...255)
        clothBlueSlider.value = Float.random(in: 0...255)
        
        handRedSlider.value = Float.random(in: 0...255)
        handGreenSlider.value = Float.random(in: 0...255)
        handBlueSlider.value = Float.random(in: 0...255)

        if gradualSwitch.isOn {
            //隨機漸層顏色(Alpha不需漸層)
            gradualViewChange()
        } else {
            //隨機顏色
            clothAlphaSlider.value = Float.random(in: 0...1)
            handAlphaSlider.value = Float.random(in: 0...1)
            colorViewChange()
        }
        //顯示數值
        sliderTextLabel()
    }
    
    //顯示數值Function
    func sliderTextLabel() {
        
        //衣服數值
        clothRedLabel.text = String(Int(clothRedSlider.value))
        clothGreenLabel.text = String(Int(clothGreenSlider.value))
        clothBlueLabel.text = String(Int(clothBlueSlider.value))
        clothAlphaLabel.text = String(format: "%.2f", clothAlphaSlider.value)
        
        //手套數值
        handRedLabel.text = String(Int(handRedSlider.value))
        handGreenLabel.text = String(Int(handGreenSlider.value))
        handBlueLabel.text = String(Int(handBlueSlider.value))
        handAlphaLabel.text = String(format: "%.2f", handAlphaSlider.value)
    }
    
    //調整顏色Function
    func colorViewChange() {
        
        //衣服調色
        clothGradualView.backgroundColor = UIColor(displayP3Red: CGFloat(clothRedSlider.value/255), green: CGFloat(clothGreenSlider.value/255), blue: CGFloat(clothBlueSlider.value/255), alpha: CGFloat(clothAlphaSlider.value))
        
        //手套調色(含左手/左手腕/右手)
        rightHandGradualView.backgroundColor = UIColor(displayP3Red: CGFloat(handRedSlider.value/255), green: CGFloat(handGreenSlider.value/255), blue: CGFloat(handBlueSlider.value/255), alpha: CGFloat(handAlphaSlider.value))

        leftHandGradualView.backgroundColor = UIColor(displayP3Red: CGFloat(handRedSlider.value/255), green: CGFloat(handGreenSlider.value/255), blue: CGFloat(handBlueSlider.value/255), alpha: CGFloat(handAlphaSlider.value))

        leftWristGradualView.backgroundColor = UIColor(displayP3Red: CGFloat(handRedSlider.value/255), green: CGFloat(handGreenSlider.value/255), blue: CGFloat(handBlueSlider.value/255), alpha: CGFloat(handAlphaSlider.value))
    }
    
    //調整漸層Function
    func gradualViewChange() {
        
        //衣服顏色漸層
        let clothGradualLayer = CAGradientLayer()
        clothGradualLayer.frame = clothGradualView.bounds
        clothGradualLayer.colors = [UIColor.init(displayP3Red: CGFloat(clothRedSlider.value/255), green: CGFloat(clothGreenSlider.value/255), blue: CGFloat(clothBlueSlider.value/255), alpha: 1).cgColor, UIColor.init(displayP3Red: CGFloat(handRedSlider.value/255), green: CGFloat(handGreenSlider.value/255), blue: CGFloat(handBlueSlider.value/255), alpha: 1).cgColor]
        clothGradualLayer.startPoint = CGPoint(x: 0.5, y: 0)
        clothGradualLayer.endPoint = CGPoint(x: 0.5, y: 1)
        clothGradualLayer.locations = [0,1]
        clothGradualView.layer.addSublayer(clothGradualLayer)
        

        //手套顏色漸層(含左手/左手腕/右手)
        let rightHandGradualLayer = CAGradientLayer()
        let leftHandGradualLayer = CAGradientLayer()
        let leftWristGradualLayer = CAGradientLayer()
        
        rightHandGradualLayer.frame = rightHandGradualView.bounds
        leftHandGradualLayer.frame = leftHandGradualView.bounds
        leftWristGradualLayer.frame = leftWristGradualView.bounds
        
        rightHandGradualLayer.colors = [UIColor.init(displayP3Red: CGFloat(clothRedSlider.value/255), green: CGFloat(clothGreenSlider.value/255), blue: CGFloat(clothBlueSlider.value/255), alpha: 1).cgColor, UIColor.init(displayP3Red: CGFloat(handRedSlider.value/255), green: CGFloat(handGreenSlider.value/255), blue: CGFloat(handBlueSlider.value/255), alpha: 1).cgColor]
        leftHandGradualLayer.colors = [UIColor.init(displayP3Red: CGFloat(clothRedSlider.value/255), green: CGFloat(clothGreenSlider.value/255), blue: CGFloat(clothBlueSlider.value/255), alpha: 1).cgColor, UIColor.init(displayP3Red: CGFloat(handRedSlider.value/255), green: CGFloat(handGreenSlider.value/255), blue: CGFloat(handBlueSlider.value/255), alpha: 1).cgColor]
        leftWristGradualLayer.colors = [UIColor.init(displayP3Red: CGFloat(clothRedSlider.value/255), green: CGFloat(clothGreenSlider.value/255), blue: CGFloat(clothBlueSlider.value/255), alpha: 1).cgColor, UIColor.init(displayP3Red: CGFloat(handRedSlider.value/255), green: CGFloat(handGreenSlider.value/255), blue: CGFloat(handBlueSlider.value/255), alpha: 1).cgColor]
        
        rightHandGradualLayer.startPoint = CGPoint(x: 1, y: 0)
        leftHandGradualLayer.startPoint = CGPoint(x: 0, y: 0)
        leftWristGradualLayer.startPoint = CGPoint(x: 0, y: 0)
        
        rightHandGradualLayer.endPoint = CGPoint(x: 0, y: 1)
        leftHandGradualLayer.endPoint = CGPoint(x: 1, y: 1)
        leftWristGradualLayer.endPoint = CGPoint(x: 1, y: 1)

        rightHandGradualLayer.locations = [0,1]
        leftHandGradualLayer.locations = [0,1]
        leftWristGradualLayer.locations = [0,1]

        rightHandGradualView.layer.addSublayer(rightHandGradualLayer)
        leftHandGradualView.layer.addSublayer(leftHandGradualLayer)
        leftWristGradualView.layer.addSublayer(leftWristGradualLayer)
    }
}

