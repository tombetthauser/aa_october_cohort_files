require "deque"

describe "Deque" do
    subject(:deque_1) { Deque.new }
    subject(:deque_2) { Deque.new }

    it "should not expose a reader or writer for @concealed_array" do
        expect(deque_1).to_not respond_to(:concealed_array, :concealed_array=)
    end

    describe "#initialize" do
        it "should set @concealed_array to an empty array" do
            expect(deque_1.instance_variable_get(:@concealed_array)).to eq([])
        end
    end

    describe "#size" do
        it "should return the total number of items currently in the deque" do
            expect(deque_1.size).to eq(0)

            deque_1.instance_variable_set(:@concealed_array, ['x', 'y', 'z'])
            expect(deque_1.size).to eq(3)

            deque_2.instance_variable_set(:@concealed_array, ['q', 'r', 's', 't', 'u', 'v'])
            expect(deque_2.size).to eq(6)
        end
    end

    describe "#blank?" do
        context "when the deque contains no items" do
            it "should return true" do
                expect(deque_1.blank?).to eq(true)
            end
        end

        context "when the deque contains some items" do
            it "should return false" do
                deque_1.instance_variable_set(:@concealed_array, ['a', 'b'])
                expect(deque_1.blank?).to eq(false)
            end
        end
    end

    describe "#front" do
        it "should return the item at the front of the deque" do
            deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
            expect(deque_1.front).to eq('a')

            deque_2.instance_variable_set(:@concealed_array, ['x', 'a', 'b', 'c', 'd'])
            expect(deque_2.front).to eq('x')
        end

        it "should not modify the deque" do
            deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
            deque_1.front
            expect(deque_1.instance_variable_get(:@concealed_array)).to eq(['a', 'b', 'c', 'd'])
        end
    end

    describe "#back" do
        it "should return the item at the back of the deque" do
            deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
            expect(deque_1.back).to eq('d')

            deque_2.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd', 'q'])
            expect(deque_2.back).to eq('q')
        end

        it "should not modify the deque" do
            deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
            deque_1.back
            expect(deque_1.instance_variable_get(:@concealed_array)).to eq(['a', 'b', 'c', 'd'])
        end
    end

    describe "#push_back" do
        it "should accept an item as an argument" do
            expect { deque_1.push_back('spinach') }.to_not raise_error
        end

        it "should add the given item to the back of the deque" do
            deque_1.push_back('spinach')
            expect(deque_1.instance_variable_get(:@concealed_array)).to eq(['spinach'])

            deque_2.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
            deque_2.push_back('e')
            expect(deque_2.instance_variable_get(:@concealed_array)).to eq(['a', 'b', 'c', 'd', 'e'])
        end

        it "should return the new size of the deque" do
            expect(deque_1.push_back('spinach')).to eq(1)

            deque_2.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
            expect(deque_2.push_back('e')).to eq(5)
        end
    end

    describe "#push_front" do
        it "should accept an item as an argument" do
            expect { deque_1.push_front('kale') }.to_not raise_error
        end

        it "should add the given item to the front of the deque" do
            deque_1.push_front('kale')
            expect(deque_1.instance_variable_get(:@concealed_array)).to eq(['kale'])

            deque_2.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
            deque_2.push_front('z')
            expect(deque_2.instance_variable_get(:@concealed_array)).to eq(['z', 'a', 'b', 'c', 'd'])
        end

        it "should return the new size of the deque" do
            expect(deque_1.push_front('kale')).to eq(1)

            deque_2.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
            expect(deque_2.push_front('z')).to eq(5)
        end
    end

    describe "#pop_back" do
        context "when there are no items in the deque" do
            it "should return nil" do
                expect(deque_1.pop_back).to eq(nil)
                expect(deque_1.instance_variable_get(:@concealed_array)).to eq([])
            end
        end

        context "when there is at least one item on the deque" do
            it "should remove the item at the back of the deque" do
                deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
                deque_1.pop_back
                expect(deque_1.instance_variable_get(:@concealed_array)).to eq(['a', 'b', 'c'])

                deque_2.instance_variable_set(:@concealed_array, ['r'])
                deque_2.pop_back
                expect(deque_2.instance_variable_get(:@concealed_array)).to eq([])
            end

            it "should return the removed element" do
                deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
                expect(deque_1.pop_back).to eq('d')

                deque_2.instance_variable_set(:@concealed_array, ['r'])
                expect(deque_2.pop_back).to eq('r')
            end
        end
    end

    describe "#pop_front" do
        context "when there are no items in the deque" do
            it "should return nil" do
                expect(deque_1.pop_front).to eq(nil)
                expect(deque_1.instance_variable_get(:@concealed_array)).to eq([])
            end
        end

        context "when there is at least one item in the deque" do
            it "should remove the item at the front of the deque" do
                deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
                deque_1.pop_front
                expect(deque_1.instance_variable_get(:@concealed_array)).to eq(['b', 'c', 'd'])

                deque_2.instance_variable_set(:@concealed_array, ['r'])
                deque_2.pop_front
                expect(deque_2.instance_variable_get(:@concealed_array)).to eq([])
            end

            it "should return the removed item" do
                deque_1.instance_variable_set(:@concealed_array, ['a', 'b', 'c', 'd'])
                expect(deque_1.pop_front).to eq('a')

                deque_2.instance_variable_set(:@concealed_array, ['r'])
                expect(deque_2.pop_front).to eq('r')
            end
        end
    end
end
