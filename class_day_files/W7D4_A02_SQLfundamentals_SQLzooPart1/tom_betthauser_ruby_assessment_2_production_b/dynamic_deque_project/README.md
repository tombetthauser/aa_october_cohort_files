# Ruby Assessment 2 Version B - DynamicDeque

In this project, you will build a `DynamicDeque`. A `Deque` (pronounced _deck_)
is a double-ended queue where you can push and pop from either end.

## File Structure

```plaintext
dynamic_deque_project/
├── Gemfile
├── README.md
├── lib
│   ├── deque.rb
│   └── dynamic_deque.rb
└── spec
    ├── deque_spec.rb
    └── dynamic_deque_spec.rb
```

## Scoring

Each passing spec will award one point, for a total of 41 points. This component
of the assessment is estimated to take 40 minutes.

## Objective

There are 41 total specs given in the `spec` directory. Your objective is to
pass as many specs as possible. We recommend that you work through the spec
files in the following order:

1. `spec/deque_spec.rb` (21 specs)
2. `spec/dynamic_deque_spec.rb` (20 specs)

## Usage

- `cd` into the project's root directory (`dynamic_deque_project`)
- `bundle install` to install dependencies
- `bundle exec rspec` to run the entire spec suite
- `bundle exec rspec spec/<spec_file_name>` to run all specs in a given spec
  file
  - for example: `bundle exec rspec spec/dynamic_deque_spec.rb`
- `bundle exec rspec spec/<spec_file_name>:<line_number>` to run the spec(s) in
  the block that contains the given line number of a given spec file
  - for example: `bundle exec rspec spec/dynamic_deque_spec.rb:117`

## API

Below is the complete list of methods that the classes will support. Note that
some methods may be overridden in the subclass.

### Deque

- #initialize
- #size
- #front
- #back
- #push_back
- #push_front
- #pop_back
- #pop_front

### DynamicDeque

- #max_volume
- #middle
