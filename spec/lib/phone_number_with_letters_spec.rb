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


describe PhoneNumberWithLetters do
  describe "::translate" do
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
      "1-877-AXP-GIFT"  => "1-877-297-4438" ,
      
      # should not translate x or ext to digits
      "1-209-233-1111 x12345"   => "1-209-233-1111 x12345",
      "1-555-123-4567 ext12345" => "1-555-123-4567 ext12345",
      "1.800.275.2273 x.1234"   => "1.800.275.2273 x.1234"
    }.
    each do |letter_number, digit_number|
      it "should translate #{letter_number} to #{digit_number}" do
        PhoneNumberWithLetters.translate(letter_number).should == digit_number
      end
    end
    
    describe "with extra spaces" do 
      it "should translate ' 1  800  got junk  ' char by char" do
        PhoneNumberWithLetters.translate(' 1  800  got junk  ').should == ' 1  800  468 5865  '
      end
    end
  end
  
  describe "::convert" do
    {
      "1-877-4-APL-PROMO"           => "1-877-4-275-776",
      "1-800-MY-IPHONE"             => "1-800-69-47466",
      "1.877.KARS.4.KIDS."          => "1.877.5277.4.54",
      "1 800 postcards"             => "1 800 7678227",
      "1 800 mattress"              => "1 800 6288737",
      # a very strange phone numbers :-)
      "1.800.mattress x007"         => "1.800.6288737 x007",
      "1.877.KARS.4.KIDS. ext1234"  => "1.877.5277.4.54 ext1234",
      "1.877.5277.4.54 ext1234"     => "1.877.5277.4.54 ext1234"
    }.
    each do |letter_number, digit_number|
      it "should convert #{letter_number} to #{digit_number}" do
        PhoneNumberWithLetters.convert(letter_number).should == digit_number
      end
    end

    it "should convert '1.800.POSTCARDS' to '1-800-7678' with base (8)" do
      PhoneNumberWithLetters.convert("1.800.POSTCARDS", 8).should == "1.800.7678"
    end
  end  
end