import Testing
import Solution
@testable import DataStructuresAndAlgorithms

@Suite("4. StacksAndQueues")
struct StacksAndQueuesTests {
  @Test
  func makeGood() async throws {
    #expect(sol.makeGood("leEeetcode") == "leetcode")
  }

  @Test
  func dailyTemperatures() async throws {
    #expect(sol.dailyTemperatures([73,74,75,71,69,72,76,73]) == [1,1,4,2,1,1,0,0])
  }

  @Test
  func nextGreaterElement() async throws {
    #expect(sol.nextGreaterElement([4,1,2], [1,3,4,2]) == [-1,3,-1])
    #expect(sol.nextGreaterElement([1,3,5,2,4], [6,5,4,3,2,1,7]) == [7,7,7,7,7])
  }
}
