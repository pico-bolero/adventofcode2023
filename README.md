# Day03
## Lessons Learned
* There was a lot of struggle with a misunderstanding that all structures are immutable. 
The documentation has instructions for updating a Map with Map.put or %{mymap| a: "value"},
but this is an illusion. Those function are returning a new map that needs to be assigned
to a variable e.g., `mymap = %{myap | a: "value"}`.
* There was also a struggle with scoping. One cannot update a variable external to a block.
For instance, if you have `mymap = %{ a: "value"}`, and entered an `if` statement
and update the map `mymap = %{mymap | a: "updated"}` you can use the updated mymap
, but once exiting the block (a.k.a `if` statement) the original value `%{ a: "value"}`
will return.
* Decomposing the tuple is nice once you know how to do it.
  ```
  with {:ok, data} <- Day03.extract_first_number_range("467..114..") do
    assert data.substring == "467"
    assert data.indices == {0,3}
  else
    {:error, msg} -> raise msg
  end
  ```
* Little misunderstanding with the `return: :index`
  ```
  indices = Regex.run(~r/\d+/, str, return: :index)
  # The first time through it return the indices in order {0,3}. 
  # The second run through, it is reversed, {5, 3} <<< my misunderstanding.
  # The result is {index, length}
  ```
* Make sure you are solving the right problem

# Day02
## Lessons Learned
* I had a problem with an Enum.all? result always returning false for the comparision
function: `parse_pull_result`. There were unit tests that passed successfully and
examples working fine. It turned out, that even though I had a type defined it
was allowing a string to be set where an integer should be. This doesn't show
up in printing the values unless you wrap the values in "#{inspect(value)}" and
then it showed the quotes around the integer.
* Setup the debugger does work with vscode
* Needed to enable the 'format on save' in VSCode for the editor
* Used `type` definitions to define struct fields
* Used `spec` to define method signatures with types
  * It is really easy to copy and paste a method definition and spec
    and forget to change one name or the other.
* An accumlator cannot be defined outside of the Enum.reduce function. It must
  be defined in the Enum.reduce function call.

# Day01
## Lessons Learned
* There was a lot of learning regarding syntax, Enum, Regex, and String functions.
* String concatenation uses <>, but a string with evaluations also works e.g.,"key: #{value}"
* The compiler is not going to give you the error messages you want.
# Testing
```bash
# Execute the tests
mix test
```
