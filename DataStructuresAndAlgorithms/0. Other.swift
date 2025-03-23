import Foundation
import Solution

extension Solution {
  // 121. Best Time to Buy and Sell Stock
  func maxProfit(_ prices: [Int]) -> Int {
    var buy = Int.max
    var ans = 0

    for price in prices {
      if price < buy {
        buy = price
      } else {
        ans = max(ans, price - buy)
      }
    }

    return ans
  }

  func maxProfit2(_ prices: [Int]) -> Int {
    var profit = 0

    for i in 1..<prices.count {
      if prices[i-1] < prices[i] {
        profit += prices[i] - prices[i - 1]
      }
    }

    return profit
  }

  // 2115. Find All Possible Recipes from Given Supplies
  func findAllRecipes(
    _ recipes: [String],
    _ ingredients: [[String]],
    _ supplies: [String]
  ) -> [String] {

    var recipes = Dictionary(
      uniqueKeysWithValues: zip(
        recipes,
        ingredients.map { Set($0) }
      )
    )
    var supplies = Set(supplies)
    var ans = Set<String>()

    for _ in 0..<recipes.count {
      for (recipe, ingredients) in recipes {
        if ingredients.isSubset(of: supplies) {
          recipes.removeValue(forKey: recipe)
          supplies.insert(recipe)
          ans.insert(recipe)
        }
      }
    }

    return Array(ans)
  }

  // 3462. Maximum Sum With at Most K Elements
  func maxSum(_ grid: [[Int]], _ limits: [Int], _ k: Int) -> Int {
    var total = [Int]()

    for i in grid.indices {
      let limit = limits[i]
      let row = grid[i].sorted(by: <)
      print(row)
      total += row[0..<limit]
    }

    return total.sorted()[0..<k].reduce(0, +)
  }

  // 48. Rotate Image
  func rotate(_ matrix: inout [[Int]]) {
    let size = matrix.count

    // transpose matrix
    for i in 0..<size {
      for j in i..<size {
        let tmp = matrix[i][j]
        matrix[i][j] = matrix[j][i]
        matrix[j][i] = tmp
      }
    }

    // reverse matrix
    for i in 0..<size {
      for j in 0..<(size/2) {
        matrix[i].swapAt(j, size - j - 1)
      }
    }
  }
}
