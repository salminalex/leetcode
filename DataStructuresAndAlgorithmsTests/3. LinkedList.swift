import Testing
import Solution
@testable import DataStructuresAndAlgorithms

@Suite("3. LinkedList")
struct LinkedListTests {
  @Test
  func reverse() async throws {
    let headGiven = ListNode(description: "1 -> 2 -> 3 -> 4 -> 5")
    let expected = ListNode(description: "5 -> 4 -> 3 -> 2 -> 1")
    #expect(sol.reverseList(headGiven)?.description == expected?.description)
  }

  @Test
  func swapPairs() async throws {
    let headGiven = ListNode(nodes: [2,5, 3,4, 6,2, 2])
    let expected = ListNode(nodes: [5,2, 4,3, 2,6, 2])
    #expect(sol.swapPairs(headGiven)?.description == expected?.description)
  }
}
