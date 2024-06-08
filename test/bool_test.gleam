import gleam/option.{None, Some}
import gleam/string

import gleeunit/should

import personal_utils/bool.{apply_if, apply_if_some} as _

pub fn apply_if_test() {
  {
    1
    |> apply_if(True, fn(x) { x + 10 })
    |> apply_if(False, fn(x) { x + 100 })
    |> apply_if(False, fn(x) { x + 1000 })
    |> apply_if(True, fn(x) { x + 10_000 })
    |> apply_if(True, fn(x) { x + 100_000 })
    |> apply_if(False, fn(x) { x + 1_000_000 })
  }
  |> should.equal(110_011)

  {
    "hello_"
    |> apply_if(True, fn(x) { x <> "a" })
    |> apply_if(False, fn(x) { x <> "b" })
    |> apply_if(False, fn(x) { x <> "c" })
    |> apply_if(True, fn(x) { x <> "d" })
    |> apply_if(True, fn(x) { x <> "e" })
    |> apply_if(False, fn(x) { x <> "f" })
  }
  |> should.equal("hello_ade")
}

pub fn apply_if_some_test() {
  {
    1
    |> apply_if_some(Some(2), fn(x, y) { x + y * 10 })
    |> apply_if_some(None, fn(x, y) { x + y * 100 })
    |> apply_if_some(None, fn(x, y) { x + y * 1000 })
    |> apply_if_some(Some(3), fn(x, y) { x + y * 10_000 })
    |> apply_if_some(Some(4), fn(x, y) { x + y * 100_000 })
    |> apply_if_some(None, fn(x, y) { x + y * 1_000_000 })
  }
  |> should.equal(430_021)

  {
    "hello_"
    |> apply_if_some(Some(2), fn(x, y) { x <> string.repeat("a", y) })
    |> apply_if_some(None, fn(x, y) { x <> string.repeat("b", y) })
    |> apply_if_some(None, fn(x, y) { x <> string.repeat("c", y) })
    |> apply_if_some(Some(3), fn(x, y) { x <> string.repeat("d", y) })
    |> apply_if_some(Some(4), fn(x, y) { x <> string.repeat("e", y) })
    |> apply_if_some(None, fn(x, y) { x <> string.repeat("f", y) })
  }
  |> should.equal("hello_aadddeeee")
}
