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
    @State var infoIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 0
    
    
    var body: some View {
        
        VStack {
            //Target row
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text(String(target))
            }
            
            //Slider row
            Spacer()
            HStack {
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                    .padding(.init(top: 0, leading: 20, bottom: 0, trailing: 20))
                Text("100")
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
                    Text("Check Value")
                        .fontWeight(.semibold)
                }
                    
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
                    Text("Start over")
                        .fontWeight(.semibold)
                }

                //Score
                Spacer()
                Text("Score:")
                Text("\(score)")
                //Score
                Spacer()
                Text("Round:")
                Text("\(round)")
                
                //Info
                Spacer()
                Button(action: {
                    self.infoIsVisible = true
                }) {
                    Text("Info")
                        .fontWeight(.semibold)
                }
                .alert(isPresented: $infoIsVisible) { () ->
                    Alert in
                    return Alert(title: Text("Info"),
                                 message: Text("Info"),
                                 dismissButton: .default(Text("Dismiss")))
                }
            }
            .padding(.init(top: 0, leading: 30, bottom: 20, trailing: 30))
        }
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
