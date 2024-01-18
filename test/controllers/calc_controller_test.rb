require "test_helper"

class CalcControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get calc_input_url
    assert_response :success
  end

  test "should get view" do
    get calc_view_url
    assert_response :success
  end

  test "should get 1210" do
    get '/calc/view?n=1210&commit=Calc+result'
    assert_equal assigns[:result], [[220, 284],[1184, 1210]]
  end

  test "should get ''" do
    get '/calc/view?n=&commit=Calc+result'
    assert_equal assigns[:result], 'Ошибка ввода'
  end


  test "should get 10" do
    get '/calc/view?n=10&commit=Calc+result'
    assert_equal assigns[:result], 'Взаимно-дружественные числа в диапазоне от 0 до 10 не найдены'
  end
end
