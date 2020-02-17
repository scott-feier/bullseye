//
//  ContentView.swift
//  Bullseye
//
//  Created by Scott Feier on 2/17/20.
//  Copyright © 2020 Scott Feier. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var whosThereIsVisible: Bool = false
    
    
    var body: some View {

        VStack {
            Text("Welcome to my first app")
                .fontWeight(.semibold)
                .foregroundColor(Color.green)

            Button(action: {
                print("Button pressed")
                self.alertIsVisible = true
            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit Me!"/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
            }

            .alert(isPresented: $alertIsVisible) { () ->
                 Alert in
                 return Alert(title: Text("Hello there!"),
                              message: Text("This is my first pop-up."),
                              dismissButton: .default(Text("Dismiss")))
             }

            Button(action: {
                self.whosThereIsVisible = true
            }) {
                Text("Knock Knock")
            }

            .alert(isPresented: $whosThereIsVisible) { () ->
                Alert in
                return Alert(title: Text("Who's There?"),
                             message: Text("Orange"),
                             dismissButton: .default(Text("Orange who?")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
