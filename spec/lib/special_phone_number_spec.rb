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
  describe "::decode" do
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
    
    describe "with extra spaces" do 
      it "should decode ' 1  800  got junk  ' to '1 800 468 5865'" do
        SpecialPhoneNumber.decode(' 1  800  got junk  ').should == '1 800 468 5865'
      end
    end
  end
  
  describe "::normalize" do
    {
      "1-877-4-APL-PROMO"     => "1-877-4-275-776",
      "1-800-MY-IPHONE"       => "1-800-69-47466" ,
      "1.877.KARS.4.KIDS."    => "1-877-5277-4-54",
      "1 800 postcards"       => "1-800-7678227"  ,
      "1 800 mattress"        => "1-800-6288737"  ,
      "1 800 mattress 0044"   => "1-800-6288737"  ,
      "1.800.matt.res.s.007"  => "1-800-6288-737"  
    }.
    each do |letter_number, pure_number|
      it "should normalize #{letter_number} to #{pure_number}" do
        SpecialPhoneNumber.normalize(letter_number).should == pure_number
      end
    end
  
    it "should normalize '1.800.POSTCARDS' to '1-800-7678' with base (8)" do
      SpecialPhoneNumber.normalize("1.800.POSTCARDS", :base => 8).should == "1-800-7678"
    end

    it "should normalize '1-800-POSTCARDS' to '1.800.7678227' with separator (.)" do
      SpecialPhoneNumber.normalize("1-800-POSTCARDS", :separator => '.').should == "1.800.7678227"
    end

    it "should normalize '1-800 POSTCARDS' to '1.800.767822' with base (10) and separator (.)" do
      SpecialPhoneNumber.normalize("1-800 POSTCARDS", :base => 10, :separator => '.').should == "1.800.767822"
    end

    describe "with extra spaces" do
      it "should normalize '  1-800  POST  CARDS ' to '1.800.7678.22' with base (10) and separator (.)" do
        SpecialPhoneNumber.normalize(" 1-800  POST  CARDS ", :base => 10, :separator => '.').should == "1.800.7678.22"
      end

      it "should normalize ' 1-800  POST ' to '1.800.7678' with separator (.) and numbers less than base (10)" do
        SpecialPhoneNumber.normalize(" 1-800  POST ", :base => 10, :separator => '.').should == "1.800.7678"
      end
    end
  end  
end