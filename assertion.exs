defmodule Assertion do
   def macro __using__(_options) do
     quote do
       import unquote(__MODULE__)
       Module.register_attribute __MODULE__, :tests, accumulate: true
       @before_compile unquote(__MODULE__)
     end
   end
end
