defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a_num, a_den}, {b_num, b_den}) do
    num = a_num * b_den + b_num * a_den
    den = a_den * b_den
    reduce({num, den})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract(a, {b_num, b_den}) do
    add(a, {-b_num, b_den})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a_num, a_den}, {b_num, b_den}) do
    {
      a_num * b_num,
      a_den * b_den
    }
    |> reduce
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by(num, {den_num, den_den}) do
    multiply(num, {den_den, den_num})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({num, den}) do
    { Kernel.abs(num), Kernel.abs(den) }
    |> reduce
  end

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({num, den}, n) when n < 0 do
    {
      Integer.pow(den, -n),
      Integer.pow(num, -n),
    }
    |> reduce
  end

  def pow_rational({num, den}, n) do
    {
      Integer.pow(num, n),
      Integer.pow(den, n),
    }
    |> reduce
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {num, den}) do
    x ** (num / den)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({num, den}) when den < 0 do
    gcd = Integer.gcd(num, den)
    {-num / gcd, -den / gcd}
  end

  def reduce({num, den}) do
    gcd = Integer.gcd(num, den)
    {num / gcd, den / gcd}
  end
end
