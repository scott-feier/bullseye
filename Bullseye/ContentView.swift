//
//  ContentView.swift
//  Bullseye
//
//  Created by Scott Feier on 2/17/20.
//  Copyright © 2020 Scott Feier. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var checkValueIsVisible: Bool = false
    @State var startOverIsVisible: Bool = false
    @State var infoIsVisible: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target: Int = Int.random(in: 1...100)
    
    
    var body: some View {

        VStack {
            //Target row
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text(String(self.target))
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
                      self.checkValueIsVisible = true
                  }) {
                      Text("Check Value")
                          .fontWeight(.semibold)
                  }
                  .alert(isPresented: $checkValueIsVisible) { () ->
                    Alert in
                    var roundedValue: Int = Int(self.sliderValue.rounded())
                        return Alert(title: Text("Current Value"),
                                     message: Text("Value is \(roundedValue)\n" +
                                        "You scored  \(pointsForCurrentRound())\n"),
                                    dismissButton: .default(Text("Dismiss")))
                   }
            }
            
            //Score row
            Spacer()
            HStack {
                //start over button
                Button(action: {
                    self.startOverIsVisible = true
                }) {
                    Text("Start over")
                        .fontWeight(.semibold)
                }
                .alert(isPresented: $startOverIsVisible) { () ->
                     Alert in
                     return Alert(title: Text("Start Over"),
                                  message: Text("Starting Over"),
                                  dismissButton: .default(Text("Dismiss")))
                 }
                //Score
                Spacer()
                Text("Score:")
                Text("999999")
                //Score
                Spacer()
                Text("Round:")
                Text("999")
                
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
    
    
    func pointsForCurrentRound() -> Int {
        var awardedPoints: Int
        var difference: Int
        var roundedValue: Int = Int(self.sliderValue.rounded())
       if roundedValue > self.target {
           difference = roundedValue - self.target
       } else if self.target > roundedValue {
           difference = self.target - roundedValue
       } else  {
           difference = 0
       }// must be equal
        
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
