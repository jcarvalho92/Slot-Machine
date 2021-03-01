//
//  DbHelper.swift
//  Slot Machine
//
//  Created by Juliana de Carvalho on 2021-02-26.
//  Copyright © 2021 Juliana de Carvalho. All rights reserved.
//  Student 1: Abdeali Mody - Student Id: 301085484
//  Student 2: Juliana de Carvalho - Student Id: 301137060

import Foundation

class DbHelper{

  init()
  {
      db = openDatabase()
      createTable()
  }
    
   var db:OpaquePointer?
  func openDatabase() -> OpaquePointer?
  {
      var db: OpaquePointer? = nil
      if sqlite3_open(dataFilePath(), &db) != SQLITE_OK
      {
          sqlite3_close(db)
          print("error opening database")
          return nil
      }
      else
      {
          print("Successfully opened connection to database")
          return db
      }
  }

  func createTable() {
      let createTableString = "CREATE TABLE IF NOT EXISTS JACKPOT " +
                              "( PAYOUT_AMOUNT DOUBLE, CREDIT DOUBLE, HIGHEST_WINNING DOUBLE );"
      var createTableStatement: OpaquePointer? = nil
      if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
      {
          if sqlite3_step(createTableStatement) == SQLITE_DONE
          {
              print("Jackpot table created.")
          } else {
              print("Jackpot table could not be created.")
          }
      } else {
          print("CREATE TABLE statement could not be prepared.")
      }
      sqlite3_finalize(createTableStatement)
  }

  func dropTable() {
      let dropTableString = "DROP TABLE IF EXISTS JACKPOT ;"
      var dropTableStatement: OpaquePointer? = nil
      if sqlite3_prepare_v2(db, dropTableString, -1, &dropTableStatement, nil) == SQLITE_OK
      {
          if sqlite3_step(dropTableStatement) == SQLITE_DONE
          {
              print("Jackpot table droped.")
          } else {
              print("Jackpot table could not be droped.")
          }
      } else {
          print("DROP TABLE statement could not be prepared.")
      }
      sqlite3_finalize(dropTableStatement)
  }

    func insert( payout_amount: Double, credit: Double, highest_winning: Double)
  {
      
      let insertStatementString = "INSERT INTO JACKPOT (PAYOUT_AMOUNT, CREDIT, HIGHEST_WINNING) " +
                                  "VALUES ('\(payout_amount)' , '\(credit)' ,  '\(highest_winning)') ;"
      var insertStatement: OpaquePointer? = nil
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
          if sqlite3_step(insertStatement) == SQLITE_DONE {

              print("Successfully inserted row.")
          } else {
              print("Could not insert row.")
          }
      } else {
          print("INSERT statement could not be prepared.")
      }
      sqlite3_finalize(insertStatement)
  }

    func update(payout_amount:Double, credit: Double, highest_winning:Double)
    {

        let updateStatementString = "UPDATE JACKPOT SET PAYOUT_AMOUNT = '\(payout_amount)', CREDIT = '\(credit)', HIGHEST_WINNING = '\(highest_winning)'  ;"
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
  
                print("Successfully updated row.")
            } else {
                print("Could not update row.")
            }
        } else {
            print("Update statement could not be prepared.")
        }
        sqlite3_finalize(updateStatement)
    }

  func read() -> Jackpot {
      
      let queryStatementString = "SELECT PAYOUT_AMOUNT, CREDIT, HIGHEST_WINNING FROM JACKPOT "
      var queryStatement: OpaquePointer? = nil
      var payout_amount: Double = 0
      var credit: Double = 0
      var highest_winning: Double = 0
    let jackpot = Jackpot(payout_amount: 0, credit: 0, highest_winning: 0)
      if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            payout_amount = Double(String(describing: String(cString: sqlite3_column_text(queryStatement, 0))))!
            credit = Double(String(describing: String(cString: sqlite3_column_text(queryStatement, 1))))!
            highest_winning = Double(String(describing: String(cString: sqlite3_column_text(queryStatement, 2))))!

            jackpot.payout_amount = payout_amount
            jackpot.credit = credit
            jackpot.highest_winning = highest_winning
            
        }
      } else {
          print("SELECT statement could not be prepared")
      }
      sqlite3_finalize(queryStatement)
      return jackpot
  }

  func dataFilePath() -> String {
          let urls = FileManager.default.urls(for:
              .documentDirectory, in: .userDomainMask)
          var url:String?
          url = urls.first?.appendingPathComponent("data.plist").path
          return url!
  }
}
