defmodule A do
  # The following defmacro definition will
  # run and inject
  # the specified code at the end of the 
  # module calling @before_compile A,
  # before its compilation starts;
  # in this specific case, the function 
  # hello/1 will be injected at the end 
  # of module B
  defmacro __before_compile__ (_env) do
    quote do
      def hello, do: "world"
    end
  end
end
