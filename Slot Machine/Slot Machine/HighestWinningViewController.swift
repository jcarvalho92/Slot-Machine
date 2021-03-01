//
//  HighestWinningViewController.swift
//  Slot Machine
//
//  Created by Juliana de Carvalho on 2021-02-28.
//  Copyright © 2021 Juliana de Carvalho. All rights reserved.
//  Student 1: Abdeali Mody - Student Id: 301085484
//  Student 2: Juliana de Carvalho - Student Id: 301137060


import UIKit

class HighestWinningViewController: UIViewController {

    @IBOutlet var Highest_label: UILabel!
    
    var highest_winning = 0 {
        didSet {
            Highest_label.text = "$\(highest_winning)"
        }
    }
    var jackpotData = Jackpot(payout_amount: 0, credit: 0, highest_winning: 0)
     var db: DbHelper = DbHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        jackpotData = db.read()
        highest_winning = Int(jackpotData.highest_winning)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
