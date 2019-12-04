# a01-prep

Assessment 1 will test general programming knowledge.

## How to prepare
Use the [A01 Practice Generator](https://github.com/appacademy/aa-practice-test-generator)!

The following is a (non-exhaustive) list of topics that may be covered:

+ Searches and Sorts
+ Recursion
+ Enumerables
+ Arrays, Strings, Hashes
+ Monkey patching

Pro-tip: read the description of the failing spec, look at the spec code, and read the error message.

Go through the debugging-practice. This is the solutions to the practice assessment, but we introduced a bunch of bugs.

### DEBUGGING
One of the main skills that will help a lot on the assessments (and our careers) is debugging systematically. For practice debugging and reading errors, we have a broken version of the prep assessment (the debugging-practice directory of this repo). A handful of common mistakes are sprinkled throughout the solutions.

Your challenge is to time yourself and try to get all the specs to pass as fast as possible. Do this not by rewriting the entire method, but by reading the RSpec errors and fixing the given code, one error at a time.

1. Read the error message or failed spec.
2. Understand what is being asked in the spec.
3. Look at the specific line of code that is failing.
4. Reason about why it might be wrong.
5. Fix & repeat.
- Remember you can run one spec or group of specs at a time: `bundle exec rspec spec/file_spec.rb:20`

**Resources**:
[A01 Practice Generator][a1-gen]

[a1-gen]: https://github.com/appacademy/aa-practice-test-generator
