//// Additional functions related to list manipulation

import gleam/bool
import gleam/dict.{type Dict}
import gleam/list
import gleam/option

/// Counts the number of times each element appears in a list.
pub fn count(list: List(a)) -> Dict(a, Int) {
  list.fold(list, dict.new(), increment_counter)
}

/// Increments the value of a key in a dictionary.
pub fn increment_counter(in dict: Dict(a, Int), update key: a) -> Dict(a, Int) {
  dict.update(dict, key, fn(value) { 1 + option.unwrap(value, 0) })
}

/// Produces a list of pairs `(x, xs)`
/// where `x` is each item from the input list
/// and `xs` is the list of the remaining items excluding `x`.
pub fn one_from_rest_combinations(list: List(a)) -> List(#(a, List(a))) {
  one_from_rest_combinations_rec([], list.reverse(list), [])
}

fn one_from_rest_combinations_rec(
  original_stack: List(a),
  reverted_stack: List(a),
  answers: List(#(a, List(a))),
) -> List(#(a, List(a))) {
  use <- bool.guard(list.is_empty(reverted_stack), answers)
  let assert [first, ..rest] = reverted_stack
  let new_answer = #(first, rebuild_from_stack(original_stack, rest))
  one_from_rest_combinations_rec([first, ..original_stack], rest, [
    new_answer,
    ..answers
  ])
}

fn rebuild_from_stack(
  original_stack: List(a),
  reverted_stack: List(a),
) -> List(a) {
  list.fold(reverted_stack, original_stack, list.prepend)
}
