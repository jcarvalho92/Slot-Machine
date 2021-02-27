//
//  DbHelper.swift
//  Slot Machine
//
//  Created by Juliana de Carvalho on 2021-02-26.
//  Copyright © 2021 Juliana de Carvalho. All rights reserved.
//
import Foundation

class DbHelper{

  init()
  {
      db = openDatabase()
    //  dropTable()
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
                              "( PAYOUT_AMOUNT DOUBLE );"
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

  func insert( payout_amount: Double)
  {
      
      let insertStatementString = "INSERT INTO JACKPOT (PAYOUT_AMOUNT) " +
                                  "VALUES ('\(payout_amount)') ;"
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

    func update(payout_amount:Double)
    {

        let updateStatementString = "UPDATE JACKPOT SET PAYOUT_AMOUNT = '\(payout_amount)'  ;"
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

  func read() -> Double {
      
      let queryStatementString = "SELECT PAYOUT_AMOUNT FROM JACKPOT "
      var queryStatement: OpaquePointer? = nil
      var payout_amount: Double = 0
    
      if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        while sqlite3_step(queryStatement) == SQLITE_ROW {
            payout_amount = Double(String(describing: String(cString: sqlite3_column_text(queryStatement, 0))))!
        
            print("Query result: ")
            print("\(payout_amount) ")
        }
      } else {
          print("SELECT statement could not be prepared")
      }
      sqlite3_finalize(queryStatement)
      return payout_amount
  }

  func dataFilePath() -> String {
          let urls = FileManager.default.urls(for:
              .documentDirectory, in: .userDomainMask)
          var url:String?
          url = urls.first?.appendingPathComponent("data.plist").path
          return url!
  }
}
