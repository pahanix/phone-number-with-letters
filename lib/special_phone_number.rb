module SpecialPhoneNumber

  DECODE_MAP = {}

  [ # ======================= #
       '1'  , '2abc' , '3def' ,
    # ======================= #
     '4ghi' , '5jkl' , '6mno' ,
    # ======================= #
     '7pqrs', '8tuv' , '9wxyz',
    # ======================= #
        '#' ,  '0'   ,  '*'   
  ].# ======================= #
  
  each do |button|
    number, *letters = button.split('')
    letters.each { |letter| DECODE_MAP[letter] = number }
  end
  
  DECODE_MAP.freeze

  def decode(number)
    number.to_s.split('').map{ |symbol| DECODE_MAP[symbol.downcase] || symbol }.join
  end
  
  alias_method :decode_phone_number, :decode
  
  module_function :decode
end