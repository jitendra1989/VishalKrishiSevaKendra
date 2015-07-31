module HumanNumbers

  NUMBERS_TO_NAME = {
      10000000 => "Crore",
      100000 => "Lakh",
      1000 => "Thousand",
      100 => "Hundred",
      90 => "Ninety",
      80 => "Eighty",
      70 => "Seventy",
      60 => "Sixty",
      50 => "Fifty",
      40 => "Forty",
      30 => "Thirty",
      20 => "Twenty",
      19 => "Nineteen",
      18 => "Eighteen",
      17 => "Seventeen",
      16 => "Sixteen",
      15 => "Fifteen",
      14 => "Fourteen",
      13 => "Thirteen",
      12 => "Twelve",
      11 => "Eleven",
      10 => "Ten",
      9 => "Nine",
      8 => "Eight",
      7 => "Seven",
      6 => "Six",
      5 => "Five",
      4 => "Four",
      3 => "Three",
      2 => "Two",
      1 => "One"
    }

  def amount_in_words
    generate_words(self.amount.to_i)
  end

  private
    def generate_words(int)
      str = ""
      NUMBERS_TO_NAME.each do |num, name|
        if int == 0
          return str
        elsif int.to_s.length == 1 && int/num > 0
          return str + "#{name}"
        elsif int < 100 && int/num > 0
          return str + "#{name}" if int%num == 0
          return str + "#{name} " + generate_words(int%num)
        elsif int/num > 0
          return str + generate_words(int/num) + " #{name} " + generate_words(int%num)
        end
      end
    end
end

