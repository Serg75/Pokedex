//
//  TaskExecutorTests.swift
//  PokedexTests
//
//  Created by Sergey Slobodenyuk on 2023-06-25.
//

import XCTest

@testable import Pokedex

final class TaskExecutorTests: XCTestCase {

	func testRunUntilSuccess_SuccessfulTask() async {

		let taskExecutor = TaskExecutor()
		
		// Define a task that always succeeds
		let task: () async -> Bool = {
			return true
		}
		
		// Perform the task with repetition
		let result = await taskExecutor.runUntilSuccess(attemptCount: 5, task: task)
		
		// Assert that the result is true (success)
		XCTAssertTrue(result)
	}
	
	func testRunUntilSuccess_FailingTask() async {

		let taskExecutor = TaskExecutor()
		
		// Define a task that always fails
		let task: () async -> Bool = {
			return false
		}
		
		// Perform the task with repetition
		let result = await taskExecutor.runUntilSuccess(attemptCount: 5, task: task)
		
		// Assert that the result is false (failure)
		XCTAssertFalse(result)
	}
		
	func testRunUntilSuccess_TimeIntervalsIncreasing() async {

		let taskExecutor = TaskExecutor()
		
		// Define a task that fails for the first 4 iterations and succeeds afterward
		var iteration = 0
		let task: () async -> Bool = {
			iteration += 1
			return iteration > 4
		}
		
		// Measure the time intervals between executions
		var intervals: [Double] = []
		var lastTime = DispatchTime.now()

		let result = await taskExecutor.runUntilSuccess(attemptCount: 10) {
			let currentTime = DispatchTime.now()
			let interval = Double(currentTime.uptimeNanoseconds - lastTime.uptimeNanoseconds) / 1_000_000_000.0
			intervals.append(interval)
			lastTime = currentTime
			return await task()
		}
		
		// Remove irrelevant first interval
		intervals = [Double](intervals.dropFirst())
		
		// Assert that the result is true (success)
		XCTAssertTrue(result)
		
		// Assert that the time intervals are increasing with ratio ~2
		let increasingIntervals = intervals.dropLast().enumerated().allSatisfy { (index, interval) in
			switch intervals[index + 1] / interval {
				case 1.8...2.2:
					return true
				default:
					return false
			}
		}
		XCTAssertTrue(increasingIntervals)
	}

}
