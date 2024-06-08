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
pub fn to_radix(number: Int, base: Int) -> Result(List(Int), InvalidBase) {
  use <- bool.guard(base < 1, Error(InvalidBase))
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
pub fn power(base: Int, exponent: Int) -> Int {
  use <- bool.guard(exponent < 0, Error(NegativeExponent))
  use <- bool.guard(exponent == 0 && base == 0, Error(Indeterminate))
  let coeffs = to_radix(exponent, 2) |> result.lazy_unwrap(fn() { panic })
  let radices =
    iterator.iterate(1, fn(x) { x * base })
    |> iterator.take(list.length(radix))
  list.map2(coeffs, radices, int.multiply)
  |> int.sum
}
