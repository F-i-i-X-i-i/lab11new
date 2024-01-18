require "test_helper"

class AnswerTest < ActiveSupport::TestCase
  test "usual situation" do
    result = Answer.new(n: 284, result: [[220, 284]])
    assert result.save
    result_other = Answer.new(n: 1284, result: [[220, 284], [1184, 1210]])
    assert result_other.save
  end

  test "create and search" do
    result = Answer.new(n: 284, result: [[220, 284]])
    assert result.save
    assert_equal result, Answer.find_by(n: 284)
  end

  test "delete" do
    Answer.delete_all
    assert_equal 0, Answer.count
  end
end
