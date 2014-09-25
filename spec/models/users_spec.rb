require 'rails_helper'

RSpec.describe User, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe "validations" do
	it "should enforce the user not to be empty" do
		user = User.new(user: '', password: "1234")
		user.valid?
		expect(user.errors[:user].size).to eq 1
	end
end

describe User do
	it "is named Donald Knuth" do
		user = User.new(user: "Donald Knuth", password: "1024")
		expect(user.user).to eq "Donald Knuth"
	end
end

describe User do
	it "has password 1024" do
		user = User.new(user: "Donald Knuth", password: "1024")
		expect(user.password).to eq "1024"
	end
end

describe User do
	it "has count 1 after adding a new user" do
		user = User.add("Donald Knuth", "0000")
		expect(user[:count]).to eq 1
	end
end

describe User do
	it "has long username" do
		name = "    2      3      5      7     11     13     17     19     23     29 
     31     37     41     43     47     53     59     61     67     71 
     73     79     83     89     97    101    103    107    109    113 
    127    131    137    139    149    151    157    163    167    173 
    179    181    191    193    197    199    211    223    227    229 
    233    239    241    251    257    263    269    271    277    281 
    283    293    307    311    313    317    331    337    347    349 
    353    359    367    373    379    383    389    397    401    409 
    419    421    431    433    439    443    449    457    461    463 
    467    479    487    491    499    503    509    521    523    541 
    547    557    563    569    571    577    587    593    599    601 
    607    613    617    619    631    641    643    647    653    659 
    661    673    677    683    691    701    709    719    727    733 
    739    743    751    757    761    769    773    787    797    809 
    811    821    823    827    829    839    853    857    859    863 
    877    881    883    887    907    911    919    929    937    941 
    947    953    967    971    977    983    991    997   1009   1013 
   1019   1021   1031   1033   1039   1049   1051   1061   1063   1069 
   1087   1091   1093   1097   1103   1109   1117   1123   1129   1151 
   1153   1163   1171   1181   1187   1193   1201   1213   1217   1223 
   1229   1231   1237   1249   1259   1277   1279   1283   1289   1291 "
		hsh = User.add(name, "0000")
		expect(hsh[:errCode]).to eq User::ERR_BAD_USERNAME
	end
end



describe User do
	it "has long password" do
		password = "    2      3      5      7     11     13     17     19     23     29 
     31     37     41     43     47     53     59     61     67     71 
     73     79     83     89     97    101    103    107    109    113 
    127    131    137    139    149    151    157    163    167    173 
    179    181    191    193    197    199    211    223    227    229 
    233    239    241    251    257    263    269    271    277    281 
    283    293    307    311    313    317    331    337    347    349 
    353    359    367    373    379    383    389    397    401    409 
    419    421    431    433    439    443    449    457    461    463 
    467    479    487    491    499    503    509    521    523    541 
    547    557    563    569    571    577    587    593    599    601 
    607    613    617    619    631    641    643    647    653    659 
    661    673    677    683    691    701    709    719    727    733 
    739    743    751    757    761    769    773    787    797    809 
    811    821    823    827    829    839    853    857    859    863 
    877    881    883    887    907    911    919    929    937    941 
    947    953    967    971    977    983    991    997   1009   1013 
   1019   1021   1031   1033   1039   1049   1051   1061   1063   1069 
   1087   1091   1093   1097   1103   1109   1117   1123   1129   1151 
   1153   1163   1171   1181   1187   1193   1201   1213   1217   1223 
   1229   1231   1237   1249   1259   1277   1279   1283   1289   1291 "
		hsh = User.add("Gauss", password)
		expect(hsh[:errCode]).to eq User::ERR_BAD_PASSWORD
	end
end


describe User do
	it "has unique user" do
		name = "Riemann"
		password = "1800"
		addHash = User.add(name, password)
		addHashAgain = User.add(name, password)
		expect(addHashAgain[:errCode]).to eq User::ERR_USER_EXISTS
	end
end


describe User do
	it "has been successfully added in the DB" do
		name = "Cauchy"
		password = "1800"
		addHash = User.add(name, password)
		expect(addHash[:errCode]).to eq User::SUCCESS
	end
end

describe User do
	it "has updated the counter" do
		timesOfLogin = 501
		name = "Chern"
		password = "190019001900UC Berkeley Professor"
		addHash = User.add(name, password)
		for i in 1..timesOfLogin - 1
			loginHash = User.login(name, password)
		end
		expect(loginHash[:count]).to eq timesOfLogin
	end
end