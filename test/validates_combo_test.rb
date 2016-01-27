require 'test_helper'

class ValidatesComboTest < ActiveSupport::TestCase

# {require_all: [:last_name]}
  test "validates require all when true" do
    user = User.new(last_name: "Vedar")
    assert user.valid?, true
  end

# {require_all: [:shoe_size], require_other: true}
  test "validates require all with require other when true" do
    user = User.new(first_name: "Darth", shoe_size: 11)
    assert user.valid?, true
  end

  test "validates require all with require other when false" do
    user = User.new(first_name: "Darth")
    assert !user.valid?, true
  end

# {require_all: [:first_name, :height]}
  test "validates multiple require all when true" do
    user = User.new(first_name: "Darth", height: 123)
    assert user.valid?, true
  end

  test "validates multiple require all when false" do
    user = User.new(first_name: "Darth", eye_color: "brown")
    assert !user.valid?, true
  end

# {require_only: [:eye_color, :height]}
  test "validates multiple require only when true" do
    user = User.new(eye_color: "Darth", height: 123)
    assert user.valid?, true
  end

  test "require only with other attributes is invalid" do
    user = User.new(eye_color: "Darth", height: 123, weight: 110)
    assert !user.valid?, true
  end

# {require_all: [:height, :weight], prohibit: [:hair_color, :eye_color]}
  test "require all without prohibited is valid" do
    user = User.new(weight: 180, height: 123)
    assert user.valid?, true
  end

  test "require all with prohibit is invalid" do
    user = User.new(eye_color: "Darth", height: 123, hair_color: "red")
    assert !user.valid?, true
  end

end
