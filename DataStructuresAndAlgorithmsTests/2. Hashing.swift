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
}
