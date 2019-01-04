////
////  Channel.swift
////  scrollViewTest
////
////  Created by Cara Brennan on 9/18/18.
////  Copyright © 2018 Cara Brennan. All rights reserved.
////
//
import Foundation

public struct Channel {
    let id: Int
    let network_name: String
    var programs: [Program]

    //give us the indexes of the program in the channel
//    then we take each index and use it to add cell
//    public mutating func add(programs: [Program]) -> [Int] {
//        var newIndexes: [Int] = []
//        for program in programs {
//
//                newIndexes.append(self.programs.count)
//                self.programs.append(program)
//            
//        }
//        return newIndexes
//    }


    init?(jsonImport: [String:Any]) {

            self.id = jsonImport["id"] as! Int
            self.network_name = jsonImport["network_name"] as! String

            let stringPrograms = jsonImport["programs"] as! [String]

            self.programs = stringPrograms.map ({
                ( title) -> Program in
                return Program(title: title, programLength: title.count)
            })
        }
    }



