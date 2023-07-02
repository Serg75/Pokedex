//
//  TaskExecutor.swift
//  Pokedex
//
//  Created by Sergey Slobodenyuk on 2023-06-25.
//

import Foundation

protocol TaskExecutorProtocol {
	
	/// Executes given code several times until the code returns true.
	/// - Parameters:
	///   - attemptCount: Maximum number of code executions.
	///   - task: The given code.
	/// - Returns: True if the last code execution returned true.
	func runUntilSuccess(attemptCount: Int, task: () async -> Bool) async -> Bool
}

struct TaskExecutor : TaskExecutorProtocol {
	
	func runUntilSuccess(attemptCount: Int, task: () async -> Bool) async -> Bool {
		var success = false
		var delay = 0.01	// 0.01s = 10 ms
		for _ in 1...attemptCount {
			success = await task()
			if success {
				return true
			}
			do {
				try await Task.sleep(nanoseconds: UInt64(delay * Double(NSEC_PER_SEC)))
				delay *= 2.0
			} catch { }
		}
		return false
	}
	
}
