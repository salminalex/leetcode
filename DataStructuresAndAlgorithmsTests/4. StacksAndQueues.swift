import Testing
import Solution
@testable import DataStructuresAndAlgorithms

@Suite("4. StacksAndQueues")
struct StacksAndQueuesTests {
  @Test
  func makeGood() async throws {
    #expect(sol.makeGood("leEeetcode") == "leetcode")
  }
}
