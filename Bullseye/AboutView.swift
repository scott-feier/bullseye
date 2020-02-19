//
//  AboutView.swift
//  Bullseye
//
//  Created by Scott Feier on 2/18/20.
//  Copyright © 2020 Scott Feier. All rights reserved.
//

import SwiftUI
let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)


struct AboutHeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.white)
            .font(Font.custom("Arial Rounded MT Bold", size:30))
            .multilineTextAlignment(.center)
            .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
    }
}

struct AboutBodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.black)
            .font(Font.custom("Arial Rounded MT Bold", size:16))
            .multilineTextAlignment(.center)
            .padding(.init(top: 0, leading: 60, bottom: 20, trailing: 60))
        
    }
}

struct AboutView: View {
    var body: some View {
        
        Group {
            VStack {
                Text("🎯 Bullseye! 🎯").modifier(AboutHeadingStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider").modifier(AboutBodyStyle())
                
                
            }
            .navigationBarTitle("About Bullseye")
            .background(beige)
            .border(Color.black, width: 5)
            .accentColor(midnightBlue)
        }
        .background(Image("Background"), alignment: .center)
        
    }
    
}



struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 667, height: 375))
    }
}
