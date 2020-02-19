//
//  ContentView.swift
//  Bullseye
//
//  Created by Scott Feier on 2/17/20.
//  Copyright © 2020 Scott Feier. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var checkValueIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 0
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .modifier(Shadow())
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size:18))
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .modifier(Shadow())
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size:24))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size:18))
        }
    }
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size:12))
        }
    }
    
    var body: some View {
        
        VStack {
            //Target row
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
                
                Text(String(target)).modifier(ValueStyle())
                
            }
            
            //Slider row
            Spacer()
            HStack {
                Text("1").modifier(ValueStyle())
                
                Slider(value: self.$sliderValue, in: 1...100)
                    .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .accentColor(Color.green)
                Text("100").modifier(ValueStyle())
                
            }
            .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            
            //Button row
            Spacer()
            HStack {
                //start over button
                Button(action: {
                    //actions before alert is shown
                    self.checkValueIsVisible = true
                }) {
                    
                    Text("Value").modifier(ButtonLargeTextStyle())
                }
                .background(Image("Button")).modifier(Shadow())
                    
                .alert(isPresented: $checkValueIsVisible) { () ->
                    Alert in
                    return Alert(title: Text(alertTitle()),
                                 message: Text("Value is \(sliderValueRounded())\n" +
                                    "You scored  \(pointsForCurrentRound())\n"),
                                 dismissButton: .default(Text("Dismiss")){
                                    //actions when dismiss is clicked
                                    self.score = self.score + self.pointsForCurrentRound()
                                    self.round = self.round + 1
                                    self.target = Int.random(in: 1...100)
                        })
                }
                
            }
            
            //Score row
            Spacer()
            HStack {
                //start over button
                Button(action: {
                    self.resetGame()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over").modifier(ButtonSmallTextStyle())
                    }
                    
                    
                }
                .background(Image("Button")).modifier(Shadow())
                
                //Score
                Spacer()
                Text("Score:").modifier(LabelStyle())
                
                
                Text("\(score)").modifier(ValueStyle())
                
                //Score
                Spacer()
                Text("Round:").modifier(LabelStyle())
                
                Text("\(round)").modifier(ValueStyle())
                
                
                //Info
                Spacer()
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 20))

            }
            .padding(.init(top: 0, leading: 30, bottom: 20, trailing: 30))
        }
        .background(Image("Background"), alignment: .center)
        .accentColor(midnightBlue)
    .navigationBarTitle("Bullseye")
    }
    
    
    
    func resetGame() {
        round = 0
        score = 0
        target = Int.random(in: 1...100)
        sliderValue = 50.0
    }
    
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let difference = amountOff()
        let bonus: Int
        
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        
        return maximumScore - difference + bonus
    }
    
    func amountOff() -> Int {
        return abs(sliderValueRounded() - target)
    }
    
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func alertTitle() -> String {
        let difference = amountOff()
        let title: String
        
        if difference == 0 {
            title = "Perfect"
        } else if difference < 20 {
            title = "Close"
        } else {
            title = "Too far"
        }
        return title
    }
    
    func pointsForCurrentRound2() -> Int {
        var awardedPoints: Int
        var difference: Int
        var roundedValue: Int
        
        roundedValue = sliderValueRounded()
        
        difference = abs(roundedValue - self.target)
        
        awardedPoints = 100 - difference
        return awardedPoints
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //Landscape iPhone 8
        ContentView().previewLayout(.fixed(width: 667, height: 375))
    }
}
