defmodule Assertion do
  # Expanded and injected when an external
  # module calls use Assertion
  # the injected code will be
  # import Assertion
  # Module.register_attribute <user module>, :tests, accumulate: true
  # @before_compile Assertion
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute __MODULE__, :tests, accumulate: true
      @before_compile unquote(__MODULE__) 
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def run do
        IO.puts "Running the tests (#{inspect @tests})"
      end
    end
  end

  defmacro test(description, do: test_block) do
    test_func = String.to_atom(description)
    quote do
      @tests {unquote(test_func), unquote(description)}
      def unquote(test_func)(), do: unquote(test_block)
    end
  end

  defmacro assert({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Assertion.Test.assert(operator, lhs, rhs)
    end
  end
end

defmodule Assertion.Test do
  def run(tests, module) do
  end

  def assert(op, lhs, rhs) do
    IO.puts op
    IO.puts lhs
    IO.puts rhs
  end
end
