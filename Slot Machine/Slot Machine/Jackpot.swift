//
//  Jackpot.swift
//  Slot Machine
//
//  Created by Juliana de Carvalho on 2021-02-28.
//  Copyright © 2021 Juliana de Carvalho. All rights reserved.
//  Student 1: Abdeali Mody - Student Id: 301085484
//  Student 2: Juliana de Carvalho - Student Id: 301137060


import Foundation

class Jackpot
{

    var payout_amount:Double = 0.0
    var credit:Double = 0.0
    var highest_winning:Double = 0.0

    
    init( payout_amount: Double, credit: Double,  highest_winning: Double)
    {
            self.payout_amount = payout_amount
            self.credit = credit
            self.highest_winning = highest_winning
     }

    init()
    {

    }

}
