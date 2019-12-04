require "deque"
require "dynamic_deque"

describe "DynamicDeque" do
    subject(:dynamic_deque_1) { DynamicDeque.new(3) }
    subject(:dynamic_deque_2) { DynamicDeque.new(5) }

    it "should inherit from Deque" do
        expect(DynamicDeque).to be < Deque
    end

    it "should not expose a reader or writer for @concealed_array" do
        expect(dynamic_deque_1).to_not respond_to(:concealed_array, :concealed_array=)
    end

    describe "#initialize" do
        it "should accept a number as an arg" do
            expect { DynamicDeque.new(3) }.to_not raise_error
            expect { DynamicDeque.new }.to raise_error
        end

        it "set @max_volume to the given number" do
            expect(dynamic_deque_1.instance_variable_get(:@max_volume)).to eq(3)
            expect(dynamic_deque_2.instance_variable_get(:@max_volume)).to eq(5)
        end
    end

    describe "#max_volume" do
        it "should return the max volume of the deque" do
            expect(dynamic_deque_1.max_volume).to eq(3)
            expect(dynamic_deque_2.max_volume).to eq(5)
        end
    end

    describe "#middle" do
        context "when the deque contains no items" do
            it "should return an empty array" do
                expect(dynamic_deque_1.middle).to eq([])
            end
        end

        context "when the deque contains an even number of items" do
            it "should return an array containing the two items that are in the center of the deque" do
                dynamic_deque_1.instance_variable_set(:@concealed_array, ['t', 'u'])
                expect(dynamic_deque_1.middle).to eq(['t', 'u'])

                dynamic_deque_2.instance_variable_set(:@concealed_array, ['q', 'r', 's', 't'])
                expect(dynamic_deque_2.middle).to eq(['r', 's'])
            end
        end

        context "when the deque contains an odd number of items" do
            it "should return an array containing the one item that is in the center of the deque" do
                dynamic_deque_1.instance_variable_set(:@concealed_array, ['t'])
                expect(dynamic_deque_1.middle).to eq(['t'])

                dynamic_deque_2.instance_variable_set(:@concealed_array, ['q', 'r', 's', 't', 'u'])
                expect(dynamic_deque_2.middle).to eq(['s'])
            end
        end
    end

    describe "#push_back" do
        it "should accept any number of arguments" do
            expect { dynamic_deque_1.push_back('t', 'u') }.to_not raise_error
            expect { dynamic_deque_2.push_back('l', 'm', 'n') }.to_not raise_error
        end

        context "when the number of arguments would cause the deque to exceed max volume" do
            it "should raise the error 'deque is full'" do
                dynamic_deque_1.instance_variable_set(:@concealed_array, ['a', 'b'])
                expect { dynamic_deque_1.push_back('x', 'y', 'z') }.to raise_error(/deque is full/)

                dynamic_deque_2.instance_variable_set(:@concealed_array, ['q', 'r', 's', 't', 'u'])
                expect { dynamic_deque_2.push_back('v') }.to raise_error(/deque is full/)
            end

            it "should not add anything to the deque" do
                dynamic_deque_1.instance_variable_set(:@concealed_array, ['a', 'b'])
                expect { dynamic_deque_1.push_back('x', 'y', 'z') }.to raise_error(/deque is full/)
                expect(dynamic_deque_1.instance_variable_get(:@concealed_array)).to eq(['a', 'b'])
            end
        end


        context "when the number of arguments would not cause the deque to exceed max volume" do
            it "should add the arguments to the back of the deque (last argument at the back)" do
                dynamic_deque_1.push_back('t', 'u')
                expect(dynamic_deque_1.instance_variable_get(:@concealed_array)).to eq(['t', 'u'])

                dynamic_deque_2.instance_variable_set(:@concealed_array, ['e', 'f'])
                dynamic_deque_2.push_back(7, 1, 8)
                expect(dynamic_deque_2.instance_variable_get(:@concealed_array)).to eq(['e', 'f', 7, 1, 8])
            end

            it "should return the new size of the deque" do
                expect(dynamic_deque_1.push_back('t', 'u')).to eq(2)

                dynamic_deque_2.instance_variable_set(:@concealed_array, ['e', 'f', 'g'])
                expect(dynamic_deque_2.push_back(7, 1)).to eq(5)
            end
        end
    end

    describe "#pop_front" do
        context "when no argument is passed in" do
            it "should remove the front item in the deque" do
                dynamic_deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c'])
                dynamic_deque_1.pop_front
                expect(dynamic_deque_1.instance_variable_get(:@concealed_array)).to eq(['b', 'c'])
            end

            it "should return an array containing the removed item" do
                dynamic_deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'e'])
                expect(dynamic_deque_1.pop_front).to match_array(['a'])
            end
        end

        context "when a number argument, n, is passed in" do
            it "should remove the front n items in the deque" do
                dynamic_deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c'])
                dynamic_deque_1.pop_front(3)
                expect(dynamic_deque_1.instance_variable_get(:@concealed_array)).to eq([])
            end

            it "should return an array containing the removed items" do
                dynamic_deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'e'])
                expect(dynamic_deque_1.pop_front(3)).to match_array(['a', 'b', 'c'])
            end

            it "should return the array of removed items sorted by the ordered that they were removed" do
                dynamic_deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'e'])
                expect(dynamic_deque_1.pop_front(3)).to eq(['a', 'b', 'c'])
            end

            context "and there are not enough items on the deque to remove" do
                it "should remove as many items as possible from the deque" do
                    dynamic_deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'e'])
                    dynamic_deque_1.pop_front(6)
                    expect(dynamic_deque_1.instance_variable_get(:@concealed_array)).to eq([])
                end

                it "should return an array containing the items that were removed and nil values for the number of items that were unable to be removed" do
                    dynamic_deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'e'])
                    expect(dynamic_deque_1.pop_front(6)).to eq(['a', 'b', 'c', 'e', nil, nil])

                    dynamic_deque_2.instance_variable_set(:@concealed_array, ['x'])
                    expect(dynamic_deque_2.pop_front(2)).to eq(['x', nil])
                end
            end
        end
    end
end
