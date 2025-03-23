import Testing
import Solution
@testable import DataStructuresAndAlgorithms

@Suite("0. Other")
struct Other {
  @Test
  func maxProfit() async throws {
    let res = sol.maxProfit([7,1,5,3,6,4])
    #expect(res == 5)
  }

  @Test
  func rotateImage() async throws {
    var matrix = [[1,2,3],[4,5,6],[7,8,9]]
    sol.rotate(&matrix)
    #expect(matrix == [[7,4,1],[8,5,2],[9,6,3]])
  }
}
