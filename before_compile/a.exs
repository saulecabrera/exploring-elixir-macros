defmodule A do
  defmacro __before_compile__ (_env) do
    quote do
      def hello, do: "world"
    end
  end
end
