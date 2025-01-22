import Foundation
import Solution

extension Solution {
  func checkIfPangram(_ sentence: String) -> Bool {
    var alphabet = Set("abcdefghijklmnopqrstuvwxyz")
    for char in sentence {
      alphabet.remove(char)
    }
    return alphabet.isEmpty
  }
  
  func missingNumber(_ nums: [Int]) -> Int {
    let numsSet = Set(nums)
    
    for num in 0...nums.count {
      if !numsSet.contains(num) {
        return num
      }
    }
    
    fatalError("Nums have all characters.")
  }
  
  func countElements(_ arr: [Int]) -> Int {
    let set = Set(arr)
    var res = 0
    
    for num in arr {
      if set.contains(num + 1) {
        res += 1
      }
    }
    
    return res
  }
}
