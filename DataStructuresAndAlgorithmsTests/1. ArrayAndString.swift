import Testing
import Solution
@testable import DataStructuresAndAlgorithms

@Suite("1. ArrayAndString")
struct ArrayAndStringTests {
  @Test
  func sortedSquares() async throws {
    let res = sol.sortedSquares([-4,-1,0,3,10])
    #expect(res == [0,1,9,16,100])
  }
  
  @Test
  func findMaxAverage() async throws {
    let res = sol.findMaxAverage([0,1,1,3,3], 4)
    #expect(res == 2)
  }
  
  @Test
  func runningSum() async throws {
    let res = sol.runningSum([1,2,3,4])
    #expect(res == [1,3,6,10])
  }
  
  @Test
  func getAverages() async throws {
    let res = sol.getAverages([7,4,3,9,1,8,5,2,6], 3)
    #expect(res == [-1,-1,-1,5,4,4,-1,-1,-1])
  }

  @Test
  func lengthOfLongestSubstringSlidingWindow() async throws {
    #expect(sol.lengthOfLongestSubstringSlidingWindow("abcabcbb") == 3)
    #expect(sol.lengthOfLongestSubstringSlidingWindow(" ") == 1)
  }
}
