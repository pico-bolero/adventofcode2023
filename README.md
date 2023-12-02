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
