import gleeunit/should

import personal_utils/int.{
  Indeterminate, InvalidBase, NegativeExponent, NegativeNumber, power, to_radix,
}

pub fn to_radix_test() {
  to_radix(0, 2)
  |> should.equal(Ok([]))

  to_radix(0, 5)
  |> should.equal(Ok([]))

  to_radix(37, 2)
  |> should.equal(Ok([1, 0, 1, 0, 0, 1]))

  to_radix(15_662_860, 16)
  |> should.equal(Ok([12, 0, 15, 15, 14, 14]))

  to_radix(77, 16)
  |> should.equal(Ok([13, 4]))

  to_radix(0, 1)
  |> should.equal(Error(InvalidBase))

  to_radix(4, 1)
  |> should.equal(Error(InvalidBase))

  to_radix(-1, 3)
  |> should.equal(Error(NegativeNumber))

  to_radix(-77, 2)
  |> should.equal(Error(NegativeNumber))
}

pub fn power_test() {
  power(0, 0)
  |> should.equal(Error(Indeterminate))

  power(6, -1)
  |> should.equal(Error(NegativeExponent))

  power(0, -9)
  |> should.equal(Error(NegativeExponent))

  power(-42, -12)
  |> should.equal(Error(NegativeExponent))

  power(-1, 0)
  |> should.equal(Ok(1))

  power(2, 0)
  |> should.equal(Ok(1))

  power(3, 23)
  |> should.equal(Ok(94_143_178_827))

  power(17, 11)
  |> should.equal(Ok(34_271_896_307_633))
}
