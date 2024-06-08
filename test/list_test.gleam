import gleam/dict
import gleam/string

import gleeunit/should

import personal_utils/list.{count, one_from_rest_combinations} as _

pub fn count_test() {
  [] |> count |> should.equal(dict.new())

  [3, 5, 2, 1, 5, 1, 1]
  |> count
  |> should.equal(dict.from_list([#(1, 3), #(2, 1), #(3, 1), #(5, 2)]))

  "ABRAKADABRA"
  |> string.to_graphemes
  |> count
  |> should.equal(
    dict.from_list([#("A", 5), #("B", 2), #("R", 2), #("K", 1), #("D", 1)]),
  )
}

pub fn one_from_rest_combinations_test() {
  [] |> one_from_rest_combinations |> should.equal([])

  [3, 5, 2, 1, 5, 1, 1]
  |> one_from_rest_combinations
  |> should.equal([
    #(3, [5, 2, 1, 5, 1, 1]),
    #(5, [3, 2, 1, 5, 1, 1]),
    #(2, [3, 5, 1, 5, 1, 1]),
    #(1, [3, 5, 2, 5, 1, 1]),
    #(5, [3, 5, 2, 1, 1, 1]),
    #(1, [3, 5, 2, 1, 5, 1]),
    #(1, [3, 5, 2, 1, 5, 1]),
  ])

  "ABRAKADABRA"
  |> string.to_graphemes
  |> one_from_rest_combinations
  |> should.equal([
    #("A", ["B", "R", "A", "K", "A", "D", "A", "B", "R", "A"]),
    #("B", ["A", "R", "A", "K", "A", "D", "A", "B", "R", "A"]),
    #("R", ["A", "B", "A", "K", "A", "D", "A", "B", "R", "A"]),
    #("A", ["A", "B", "R", "K", "A", "D", "A", "B", "R", "A"]),
    #("K", ["A", "B", "R", "A", "A", "D", "A", "B", "R", "A"]),
    #("A", ["A", "B", "R", "A", "K", "D", "A", "B", "R", "A"]),
    #("D", ["A", "B", "R", "A", "K", "A", "A", "B", "R", "A"]),
    #("A", ["A", "B", "R", "A", "K", "A", "D", "B", "R", "A"]),
    #("B", ["A", "B", "R", "A", "K", "A", "D", "A", "R", "A"]),
    #("R", ["A", "B", "R", "A", "K", "A", "D", "A", "B", "A"]),
    #("A", ["A", "B", "R", "A", "K", "A", "D", "A", "B", "R"]),
  ])
}
