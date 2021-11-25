require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name:"chuanqizhu",email:"chuanqi@mail.com", password:"123456", password_confirmation:"123456")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

   test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test "email should be be too long" do
    @user.email = 'a' * 250 + '@email.com'
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email address should be saved as lower-cases" do
      mixed_case_email = "CHUANQI.zhu@email.com"
      @user.email = mixed_case_email
      @user.save
      assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should not be space" do
    @user.password = @user.password_confirmation = " "*6
    assert_not @user.valid?
  end

    test "password should be longer than 6" do
    @user.password = @user.password_confirmation = " "*5
    assert_not @user.valid?
  end

end
