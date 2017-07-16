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

    def pluck(key)
      map(&:"#{key}")
    end

    def find_by(number_of_section:)
      find { |f| f.number_of_section == number_of_section }
    end

    def find_by_gates(from, to)
      number_of_section = (from.station_number - to.station_number).abs
      find_by(number_of_section: number_of_section)
    end
  end
end
