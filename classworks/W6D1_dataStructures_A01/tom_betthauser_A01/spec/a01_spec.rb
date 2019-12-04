require 'rspec'
# require 'spec_helper'
require 'a01'

describe "#merge_sort" do
  # write a new `Array#merge_sort` method; it should not modify the
  # array it is called on, but create a new sorted array.
  let(:array) { [1, 2, 3, 4, 5].shuffle }

  it "works with an empty array" do
    expect([].merge_sort).to eq([])
  end

  it "works with an array of one item" do
    expect([1].merge_sort).to eq([1])
  end

  it "sorts numbers" do
    expect(array.merge_sort).to eq(array.sort)
  end

  it "sorts arrays with duplicates" do
    expect([5, 4, 3, 3, 2, 1].merge_sort).to eq([1, 2, 3, 3, 4, 5])
  end

  it "will use block if given" do
    reversed = array.merge_sort do |num1, num2|
      # reverse order
      num2 <=> num1
    end
    expect(reversed).to eq([5, 4, 3, 2, 1])
  end

  it "does not modify original" do
    duped_array = array.dup
    duped_array.merge_sort
    expect(duped_array).to eq(array)
  end

  it "calls the merge helper method" do
    expect(Array).to receive(:merge).at_least(:once).and_call_original
    array.merge_sort
  end
end

describe "#two_sum" do
  # Write a new `Array#two_sum` method that determines whether
  # an array has positions where the elements at those positions
  # sum to zero.

  it "finds a matching pair" do
    expect([5, 1, -7, -5].two_sum).to eq(true)
  end

  it "works with multiple pairs" do
    expect([5, -1, -5, 1].two_sum).to eq(true)
  end

  it "works with multiple pairs for the same element" do
    expect([5, -5, -5].two_sum).to eq(true)
  end

  it "returns false when no pair is found" do
    expect([5, 5, 3, 1].two_sum).to eq(false)
  end

  it "won't find spurious zero pairs" do
    expect([0, 1, 2, 3].two_sum).to eq(false)
  end

  it "will find real zero pairs" do
    expect([0, 1, 2, 0].two_sum).to eq(true)
  end
end

describe "#fibs_rec" do
  # write a recursive implementation of a method that returns the
  # first `n` fibonacci numbers.

  it "returns first fibonacci number" do
    expect(fibs_rec(1)).to eq([0])
  end

  it "returns first two fib numbers" do
    expect(fibs_rec(2)).to eq([0, 1])
  end

  it "returns many fibonacci numbers" do
    expect(fibs_rec(6)).to eq([0, 1, 1, 2, 3, 5])
  end

  it "calls itself recursively" do
    expect(self).to receive(:fibs_rec).at_least(:twice).and_call_original
    fibs_rec(6)
  end
end

# This method returns true if every character (ignoring spaces) is
# unique.
describe "all_unique_chars?" do
  it "properly detects a string with unique characters" do
    expect("thequickbrown".all_unique_chars?()).to eq(true)
  end

  it "properly ignores spaces" do
    expect("the quick brown".all_unique_chars?()).to eq(true)
  end

  it "can identify a string that contains repeated characters" do
    expect("the quick brown duck".all_unique_chars?()).to eq(false)
  end

  it "returns true for an empty string" do
    expect("".all_unique_chars?).to eq(true)
  end
end

# This method returns the largest factor of
# the number that is prime.
describe 'largest_prime_factor' do
  it 'returns 2 for 2' do
    expect(largest_prime_factor(2)).to eq(2)
  end

  it 'returns 5 for 10' do
    expect(largest_prime_factor(10)).to eq(5)
  end
  it 'can detect larger factors' do
    expect(largest_prime_factor(152)).to eq(19)
  end
  it 'can detect even larger factors' do
    expect(largest_prime_factor(2098)).to eq(1049)
  end

  it "returns original number if it is prime" do
    expect(largest_prime_factor(13)).to eq(13)
  end

  it 'returns nil for zero and one' do
    expect(largest_prime_factor(0)).to be_nil
    expect(largest_prime_factor(1)).to be_nil
  end
end

describe 'Array#my_each' do
  it 'calls the block passed to it' do
    expect do |block|
      ["test array"].my_each(&block)
    end.to yield_control.once
  end

  it 'yields each element to the block' do
    expect do |block|
      ["el1", "el2"].my_each(&block)
    end.to yield_successive_args("el1", "el2")
  end

  it 'does NOT call the Array#each or Array#map! method' do
    original_array = ["original array"]
    expect(original_array).not_to receive(:each)
    expect(original_array).not_to receive(:map!)
    original_array.my_each {}
  end

  it 'is chainable and returns the original array' do
    original_array = ["original array"]
    expect(original_array.my_each {}).to be(original_array)
  end
end

describe 'Array#my_all?' do
  it 'calls the block passed to it' do
    expect do |block|
      [true].my_all?(&block)
    end.to yield_control
  end

  it 'returns false if any call to the block evaluates to a falsey value' do
    expect([true, false, true].my_all? { |el| el }).to eq(false)
    expect([true, nil, true].my_all? { |el| el }).to eq(false)
  end

  it 'returns true if every call to the block evaluates to true' do
    expect([2, 4, 6].my_all? { |el| el.even? }).to eq(true)
  end

  it 'returns true if every call to the block evaluates to truthy values' do
    expect([:a, :b, :c].my_all? { |el| el }).to eq(true)
  end

  it 'does NOT call the built-in Array#all?, #none?, #any?' do
    test_array = ["el1", "el2", "el3"]

    [:all?, :none?, :any?].each do |method|
      expect(test_array).not_to receive(method)
    end

    test_array.my_all? {}
  end
end

