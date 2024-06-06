//// Additional functions for working with conditional expressions.

import gleam/option.{type Option, None, Some}

/// Applies the function to the `value` if the condition holds.
/// Otherwise, the `value` is left untouched.
pub fn apply_if(value: a, when condition: Bool, with fun: fn(a) -> a) -> a {
  case condition {
    True -> fun(value)
    False -> value
  }
}

/// Applies the function to the `value` with the `other` value if it is `Some`.
/// Otherwise, `value` is left untouched.
pub fn apply_if_some(
  value: a,
  and other: Option(b),
  with apply_fn: fn(a, b) -> a,
) -> a {
  case other {
    Some(other) -> apply_fn(value, other)
    None -> value
  }
}
