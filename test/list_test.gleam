import gleeunit/should

import personal_utils/list.{combinations}

pub fn combinations_test() {
  combinations([], 0)
  |> should.equal([[]])

  combinations([1], 0)
  |> should.equal([[]])

  combinations([1], 1)
  |> should.equal([[1]])

  combinations([1, 2, 3], 0)
  |> should.equal([[]])

  combinations([1, 2, 3], 1)
  |> should.equal([[1], [2], [3]])

  combinations([1, 2, 3], 2)
  |> should.equal([[1, 2], [1, 3], [2, 3]])

  combinations([1, 2, 3], 3)
  |> should.equal([[1, 2, 3]])

  combinations(["a", "c", "e"], 2)
  |> should.equal([["a", "c"], ["a", "e"], ["c", "e"]])
}
