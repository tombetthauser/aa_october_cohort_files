class User < ApplicationRecord

    validates :email, presence: true {
      message: 'should be letters and the @ symbol and .com'
    }

end

# Person.create(name: 'John Doe').valid? # => true
# Person.create(name: nil).valid? # => false


# class Holiday < ApplicationRecord
#   # no two Holidays with the same name for a single year
#   validates :name, uniqueness: {
#     scope: :year,
#     message: 'should happen once per year'
#   }
# end