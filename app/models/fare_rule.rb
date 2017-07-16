class FareRule
  include ActiveModel::Model

  attr_accessor :number_of_section, :money

  class << self
    include Enumerable

    def all
      [
        new(number_of_section: 1, money: 150),
        new(number_of_section: 2, money: 190)
      ]
    end

    def each(&block)
      all.each(&block)
    end
  end
end
