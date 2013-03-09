# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "John Doe", email: "john.doe@gmail.com",
			password: "foobar", password_confirmation: "foobar")
	end

	subject { @user }

	it { should respond_to (:name) }
	it { should respond_to (:email) }
	it { should respond_to (:password_digest) }
	it { should respond_to (:password) }
	it { should respond_to (:password_confirmation) }

	it { should be_valid }

	it { should respond_to (:authenticate) }

	describe "when name is missing" do
		before { @user.name = ""}
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			emails = %w[user@foo,com user_at_foo.org example.user@foo.
	                     foo@bar_baz.com foo@bar+baz.com foo@.co.il]
	        emails.each do |email|
	        	@user.email = email
	        	@user.should_not be_valid 
	        end
	    end
    end

    describe "when email format is valid" do
		it "should be valid" do
			emails = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn foo@99.co.il]
	        emails.each do |email|
	        	@user.email = email
	        	@user.should be_valid 
	        end
	    end
    end

    describe "when email is already taken" do
    	before do
    		user_with_same_mail = @user.dup
    		user_with_same_mail.email = @user.email.upcase
    		user_with_same_mail.save
    	end

    	it { should_not be_valid }
    end

    describe "empty password" do 
    	before do 
    		@user.password = @user.password_confirmation = " "
    	end

    	it { should_not be_valid }
    end

    describe "password does not match confirmation" do 
    	before do
    		@user.password_confirmation = "mismatch"
    	end

    	it { should_not be_valid }
    end


    describe "password_confirmation is nil" do
    	before do
    		@user.password_confirmation = nil
    	end

    	it { should_not be_valid }
    end

    describe "password is too short" do
    	before do 
    		@user.password = @user.password_confirmation = "a" * 5
    	end

    	it { should_not be_valid }
    end

    describe "return value of authenticate method" do
    	before { (@user.save) }
    	let (:found_user) { User.find_by_email(@user.email) }

    	describe "with valid password" do
    		it { should == found_user.authenticate(@user.password) }
    	end

    	describe "with invalid password" do
    		let (:user_invalid_password) { found_user.authenticate("invalid") }

    		it { should_not == user_invalid_password }
    		specify { user_invalid_password.should be_false}
    	end
    end

end
