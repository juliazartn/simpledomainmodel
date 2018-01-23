//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
    
  
//  public func convert(_ to: String) -> Money {
//
//  }
//
//  public func add(_ to: Money) -> Money {
//
//  }
//
//  public func subtract(_ from: Money) -> Money {
//
//  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch self.type {
    case .Hourly(let num):
        return Int(num * Double(hours))
    case .Salary(let num):
        return num
    }
  }
  
  open func raise(_ amt : Double) {
    switch self.type {
    case .Hourly(let num):
        let newHourly = Job.JobType.Hourly(num + amt)
        self.type = newHourly
    case .Salary(let num):
        let newSalary = Job.JobType.Salary(num + Int(amt))
        self.type = newSalary
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return self._job }
    set(value) {
        if(age >= 16) {
            self._job = value
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return self._spouse }
    set(value) {
        if(age >= 18) {
            self._spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(String(describing: self._job)) spouse:\(String(describing: self._spouse))]"
  }
}

//////////////////////////////////////
//// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if(spouse1._spouse == nil && spouse2._spouse == nil) {
        spouse1._spouse = spouse2
        spouse2._spouse = spouse1
    
        members.append(spouse1)
        members.append(spouse2)
    }
  }
  
  open func haveChild(_ child: Person) -> Bool {
    var adult = false
    for n in members {
        if n.age >= 21 {
            adult = true
        }
    }
    
    if adult {
        members.append(child)
        return true
    }
    return false
  }
  
  open func householdIncome() -> Int {
    var total = 0
    for n in members {
        if((n.job) != nil) {
            total += (n.job?.calculateIncome(2000))!
        }
    }
    return total
  }
}



