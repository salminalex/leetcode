import Testing
import Solution
@testable import DataStructuresAndAlgorithms

@Suite("2. Hashing")
struct HashingTests {
  @Test
  func checkIfPalindrome() async throws {
    let res = sol.checkIfPangram("thequickbrownfoxjumpsoverthelazydog")
    #expect(res == true)
  }

  @Test
  func subarrayExactSum() async throws {
    #expect(sol.subarraySum([1,1,1], 2) == 2)
    #expect(sol.subarraySum([1, -1, 1, -1], 0) == 4)
  }

  @Test
  func findWinners() async throws {
    #expect(sol.findWinners([[2,3],[1,3],[5,4],[6,4]]) == [[1,2,5,6],[]])
  }

  @Test
  func maxNumberOfBalloons() async throws {
    #expect(sol.maxNumberOfBalloons("leetcode") == 0)
  }
}
