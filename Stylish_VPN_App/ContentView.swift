//
//  ContentView.swift
//  Stylish_VPN_App
//
//  Created by park kyung suk on 2021/01/12.
//  Copyright © 2021 park kyung suk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    @State var selected = servers[0]
    @State var isServerOn = false
    
    var body: some View {
        
        VStack {
            
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10.0).stroke(Color.white.opacity(0.5), lineWidth: 0.5))
                })
                Spacer()
                Button(action: {}, label: {
                    HStack {
                        Image(systemName: "creditcard")
                            .foregroundColor(.yellow)
                        
                        Text("Go Premium")
                            .fontWeight(.heavy)
                            .font(.caption)
                            .foregroundColor(.white)
                            
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Capsule())
                    
                    
                })
            }.padding()
            
            
            //国を選ぶエリア
            ScrollView(.horizontal, showsIndicators: false, content:  {
                HStack(spacing: 15) {
                    ForEach(servers) { server in
                        Image(server.flag)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                            .opacity(self.selected.id == server.id ? 1 : 0.5)
                            .onTapGesture {
                                withAnimation { self.selected = server }
                        }
                    .padding(5)
                        .background(Circle().stroke(Color.white.opacity(self.selected.id == server.id ? 1 : 0), lineWidth: 1))
                    }
                }
                .padding(2)
            })
                .padding()
            
            
            
            //ワールドマップ
            
            ZStack {
                Image("world")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                
                VStack(spacing: 8) {
                    
                    if isServerOn {
                        Text(selected.name)
                            .fontWeight(.semibold)
                    }
                    
                    Text(self.isServerOn ? "Connected" : "Not Connected")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                    if isServerOn {
                        HStack {
                            Image(selected.flag)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .clipShape(Circle())
                            
                            Text("222.333.444.56")
                                .fontWeight(.semibold)
                        }.foregroundColor(.white)
                    }
                    
                }.offset(x: 0, y: -20)
                
            }
            
            
            // Toggle Button
            ZStack(alignment: .init(horizontal: .center, vertical: self.isServerOn ? .bottom : .top), content: {
                
                Capsule()
                    .fill(Color(self.isServerOn ? "dragbg1" :"dragbg2"))
                
                
                // Arrows 矢印
                VStack {
                    
                    if !self.isServerOn { Spacer() }
                    
                    Image(systemName: "chevron.\(self.isServerOn ? "up" : "down")")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    Image(systemName: "chevron.\(self.isServerOn ? "up" : "down")")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color.white.opacity(0.7))
                    
                    if self.isServerOn { Spacer() }
                }.offset(y: self.isServerOn ? 30 : -30)
                
                
                ZStack {
                    Capsule()
                        .fill(Color(self.isServerOn ? "drag2" : "drag1"))
                        .frame(height: 180)
                        .padding(8)
                    
                    
                    VStack(spacing: 15) {
                        Capsule()
                            .fill(self.isServerOn ? Color.black.opacity(0.45) : Color.green)
                            .frame(width: 30, height: 8)
                        
                        Text(self.isServerOn ? "STOP" : "START")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        
                        Image(systemName: "power")
                            .font(.system(size: 24, weight: .bold))
                            .padding(10)
                            .background(Color.black.opacity(0.25))
                            .clipShape(Circle())
                    }
                }.onTapGesture {
                    withAnimation { self.isServerOn.toggle() }
                }
                
            })
                .frame(width: 130)
                .padding(.bottom, 60)
            
        }
        .background(
            LinearGradient(gradient: .init(colors: [self.isServerOn ? Color("bg11") : Color("bg21"), self.isServerOn ? Color("bg12") : Color("bg22")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .animation(.easeIn)
        )
            .preferredColorScheme(.dark)
    }
}


// Server Model and Model Data

struct Server: Identifiable {
    var id = UUID().uuidString
    var name: String
    var flag: String
}

var servers = [
    Server(name: "United States", flag: "us"),
    Server(name: "Indea", flag: "in"),
    Server(name: "United Kingdom", flag: "uk"),
    Server(name: "France", flag: "fr"),
    Server(name: "Germany", flag: "ge"),
    Server(name: "Singapore", flag: "si")
]
