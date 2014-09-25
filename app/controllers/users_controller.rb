class UsersController < ApplicationController

	# POST users/add
	def add
		@errCode_and_count = User.add(params[:user], params[:password])
		render json: @errCode_and_count
	end


	# POST users/login
	def login
		@errCode_and_count = User.login(params[:user], params[:password])
		render json: @errCode_and_count
	end

	def resetFixture
		@errCode_and_count = User.TESTAPI_resetFixture
		render json: @errCode_and_count
	end

	def unitTests
		@errCode_and_count = User.TESTAPI_unitTests
		render json: @errCode_and_count
	end
end