//// Additional functions related to dict manipulation

import gleam/dict.{type Dict}
import gleam/option

/// Increments the value of a key in a dictionary.
pub fn increment_counter(in dict: Dict(a, Int), update key: a) -> Dict(a, Int) {
  dict.update(dict, key, fn(value) { 1 + option.unwrap(value, 0) })
}
