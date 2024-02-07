import UIKit

// Return students in descending order (form highest to lowest) based on their average best 3 grades

let students = ["John", "Mat", "Jen", "Tom", "Emma"]

let grades = [[80, 90, 70, nil], [nil, 50, 70, 60], [85, 95, nil, 75], [15, 35, 25, 65], [nil, nil, 30, nil]]


func highestThreeNumbers(array: [Int]) -> [Int] {
    guard array.count > 3 else {
        return array
    }
    
    let sortedArray = array.sorted(by: >)
    let firstThreeElements = Array(sortedArray[0...2])
    return firstThreeElements
}


func bestStudents(gradeList: [[Int?]], students: [String]) -> [String] {
    var gradesAndStudents: [Int: String] = [:]
    var averageGrades: [Int] = []
    
    for (index, grades) in gradeList.enumerated() {
        // Removing nil values
        let gradesWithoutNilValues: [Int] = grades.compactMap{$0}
        // Getting only the 3 highest grades
        let threeHighestGrades = highestThreeNumbers(array: gradesWithoutNilValues)
        // Adding them together
        let addedGrades = threeHighestGrades.reduce(0) {$0 + $1}
        averageGrades.append(addedGrades)
        // Retrieving student name for a corresponding grade
        let studentName = students[index]
        // Placing the grade and student in a dictionary, using the grade as a key.
        gradesAndStudents[addedGrades] = studentName
    }
    
    // Sorting the grades from highest to lowest
    let sortedGrades = averageGrades.sorted(by: >)
    var studentNamesSorted: [String] = []
    
    // Retrieving the student name for a corresponding grade
    for grade in sortedGrades {
        if let student = gradesAndStudents[grade] {
            studentNamesSorted.append(student)
        }
    }
    
    return studentNamesSorted
}


// MARK: - Tests

import XCTest

class BestStudentsTests: XCTestCase {
    func testExampleOne() {
        let students = ["John", "Mat", "Jen", "Tom", "Emma"]
        // 240, 180, 255, 105, 30
        let grades = [[80, 90, 70, nil], [nil, 50, 70, 60], [85, 95, nil, 75], [15, 35, 25, 65], [nil, nil, 30, nil]]
        
        let output = ["Jen", "John", "Mat", "Tom", "Emma"]
        
        XCTAssertEqual(bestStudents(gradeList: grades, students: students), output)
    }
    
    func testSimpleTwoValues() {
        let students = ["A", "B"]
        let grades = [[10, 10, 10, nil], [nil, 20, 20, 20]]
        
        let output = ["B", "A"]
        
        XCTAssertEqual(bestStudents(gradeList: grades, students: students), output)
    }
    
    func testSimpleTwoValuesWithOnlyNilValuesInOneOfThem() {
        let students = ["A", "B"]
        // 30, 0
        let grades = [[10, 10, 10, nil], [nil, nil, nil, nil]]
        
        let output = ["A", "B"]
        
        XCTAssertEqual(bestStudents(gradeList: grades, students: students), output)
    }
    
    func testSimpleTwoValuesWithFiveNumbersInEach() {
        let students = ["A", "B"]
        let grades = [[10, 10, 10, 10, 10], [20, 20, 20, 20, 20]]
        
        let output = ["B", "A"]
        
        XCTAssertEqual(bestStudents(gradeList: grades, students: students), output)
    }
    
    func testSimpleTwoValuesWithFiveNumbersInEach_WithSomeHighAndLowNumbers() {
        let students = ["A", "B"]
        // 150, 140
        let grades = [[10, 10, 20, 30, 100], [20, 20, 5, 5, 100]]
        
        let output = ["A", "B"]
        
        XCTAssertEqual(bestStudents(gradeList: grades, students: students), output)
    }
}

BestStudentsTests.defaultTestSuite.run()

// MARK: - Test finding 3 highest numbers in an array

class HighestNumbersTests: XCTestCase {
    func testWithFourNumbersInAnArray() {
        let input = [15, 35, 25, 65]
        let output = [65, 35, 25]
        XCTAssertEqual(highestThreeNumbers(array: input), output)
    }
    
    func testWithSixNumbersInAnArray() {
        let input = [15, 35, 25, 65, 12, 10]
        let output = [65, 35, 25]
        XCTAssertEqual(highestThreeNumbers(array: input), output)
    }
    
    func testReturnedArrayHasOnlyThreeItemsInIt() {
        let input = [15, 35, 25, 65]
        let output = [65, 35, 25]
        XCTAssertEqual(highestThreeNumbers(array: input).count, 3)
    }
    
    func testOneNumber() {
        let input = [15]
        let output = [15]
        XCTAssertEqual(highestThreeNumbers(array: input), output)
    }
}

HighestNumbersTests.defaultTestSuite.run()
