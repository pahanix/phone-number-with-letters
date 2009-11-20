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
    number.to_s.strip.gsub(/\s+/, ' ').split('').map{ |symbol| DECODE_MAP[symbol.downcase] || symbol }.join
  end
  
  alias_method :decode_phone_number, :decode
  
  def normalize(phone_number, options = {})
    options = { :base => 11, :separator => '-'}.merge(options)
    phone_number = decode(phone_number).gsub(/[^\d]/, options[:separator])
    phone_number[/(\d[^\d]*){#{options[:base]-1}}\d/] || phone_number
  end
  
  module_function :decode
  module_function :normalize
end