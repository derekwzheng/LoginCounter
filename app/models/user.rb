class User < ActiveRecord::Base
	# Error codes
	SUCCESS = 1
	ERR_BAD_CREDENTIALS = -1
	ERR_USER_EXISTS = -2
	ERR_BAD_USERNAME = -3
	ERR_BAD_PASSWORD = -4
	MAX_USERNAME_LENGTH = 128
	MAX_PASSWORD_LENGTH = 128


	# Input validation
	# username validation
	validates :user, 
		uniqueness: true,
	    presence: true,
	    length: { maximum: MAX_USERNAME_LENGTH }
	# password invalidation
	validates :password, presence: false # Login counter accepts empty password.
	validates :password, uniqueness: false
	validates :password, length: { maximum: MAX_PASSWORD_LENGTH }

	# Three public methods required by the spec.
	# This function checks that the user does not exists, the user name is not empty.
	def self.add(usrnm, psswrd)
		newUser = User.new(user: usrnm, password: psswrd, count: 1)
		if newUser.valid?
			newUser.save
			return {errCode: SUCCESS, count: 1}
		elsif User.exists?(user: usrnm)
			return {errCode: ERR_USER_EXISTS}
		elsif usrnm.length == 0 or usrnm.length > MAX_USERNAME_LENGTH
			return {errCode: ERR_BAD_USERNAME}
		else
			return {errCode: ERR_BAD_PASSWORD}
		end
	end

	# This function checks the user/password in the database.
	def self.login(usrnm, psswrd)
		if User.exists?(user: usrnm, password: psswrd)
			u = User.where(user: usrnm, password: psswrd).first
			u.count += 1
			u.save
			return {errCode: SUCCESS, count: u.count}
		else
			return {errCode: ERR_BAD_CREDENTIALS}
		end
	end

	# This method is used only for testing, and should clear the database of all rows.
	def self.TESTAPI_resetFixture
		User.destroy_all
		return {errCode: SUCCESS}
	end

  # This method is used only for testing, and it runs all the unit tests and functional tests automatically.
	def self.TESTAPI_unitTests
		cmd = "rspec > unitTestLog.txt"
		system(cmd)
		testResultFile = File.open("unitTestLog.txt", "r")
		testData = testResultFile.read
		testResultFile.close
		numExamples, numFailures, numPending = testData.match(/^(\d+)\sexamples,\s(\d+)\sfailures,\s(\d+)\spending$/i).captures
		nrFailed_output_totalTests = {nrFailed: numFailures.to_i,
			output: testData, totalTests: numExamples.to_i}
		return nrFailed_output_totalTests
	end
end
