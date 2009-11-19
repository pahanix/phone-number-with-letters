require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# ======================== #
#   '1'  , '2abc' , '3def' #
# ======================== #
# '4ghi' , '5jkl' , '6mno' #
# ======================== #
# '7pqrs', '8tuv' , '9wxyz'# 
# ======================== #
#    '#' ,  '0'   ,  '*'   #
# ======================== #


describe SpecialPhoneNumber do
  {
    "1-800-APPLE-TV"  => "1-800-27753-88" ,
    "1-800-PRINT-ME"  => "1-800-77468-63" ,
    "1-800-FLOWERS"   => "1-800-3569377"  ,
    "1-800-PET-MEDS"  => "1-800-738-6337" ,
    "1 800 dentist"   => "1 800 3368478"  ,
    "1 800 radiator"  => "1 800 72342867" ,
    "1 800 got junk"  => "1 800 468 5865" ,
    "1 800 pick ups"  => "1 800 7425 877" ,
    "1-800-APL-CARE"  => "1-800-275-2273" ,
    "1-877-AXP-GIFT"  => "1-877-297-4438"    
  }.
  each do |letter_number, pure_number|
    it "should decode #{letter_number} to #{pure_number}" do
      SpecialPhoneNumber.decode(letter_number).should == pure_number
    end
  end
end