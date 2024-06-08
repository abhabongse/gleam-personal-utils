import gleam/bool
import gleam/int
import gleam/iterator.{Done, Next}
import gleam/list
import gleam/result

/// Error type for radix conversion.
pub type RadixError {
  InvalidBase
  NegativeNumber
}

/// Error type for power function.
pub type PowerError {
  NegativeExponent
  Indeterminate
}

/// Converts a `number` to a list of digits in the given `base`.
/// The starting `number` must be non-negative
/// whereas the `base` must be a positive integer.
/// The result will be an empty string if the given `number` is `0`.
pub fn to_radix(number: Int, base: Int) -> Result(List(Int), RadixError) {
  use <- bool.guard(base < 2, Error(InvalidBase))
  use <- bool.guard(number < 0, Error(NegativeNumber))
  use <- bool.guard(number == 0, Ok([]))
  iterator.unfold(number, fn(number) {
    use <- bool.guard(number == 0, Done)
    let quotient = number / base
    let remainder = number % base
    Next(remainder, quotient)
  })
  |> iterator.to_list
  |> Ok
}

/// Power function that operates in `log(exponent)` (i.e. linear) time
pub fn power(base: Int, exponent: Int) -> Result(Int, PowerError) {
  use <- bool.guard(exponent < 0, Error(NegativeExponent))
  use <- bool.guard(exponent == 0 && base == 0, Error(Indeterminate))
  let coeffs = to_radix(exponent, 2) |> result.lazy_unwrap(fn() { panic })
  let radices =
    iterator.iterate(base, fn(x) { x * x })
    |> iterator.take(list.length(coeffs))
    |> iterator.to_list
  list.zip(coeffs, radices)
  |> list.key_filter(1)
  |> list.fold(1, int.multiply)
  |> Ok
}
