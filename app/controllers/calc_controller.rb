def sum_of_div(num)
  sum = 1
  (2..Math.sqrt(num).ceil - 1).each do |i|
    sum += i if (num % i).zero?
    sum += num / i if (num % i).zero? && i*i != num
  end
  num > 1 ? sum : 0
end

def exists_mutually_friendly(number, n)
  sum_of_div(number) <= n && sum_of_div(sum_of_div(number)) == number && sum_of_div(number) != number
end

class String
  def is_number?
    scan(/\D/).empty?
  end
end

def my_to_arr(str)
  arr1 = str.split(' ')
  arr2 = []
  for i in (1..arr1.length/2)
    arr2.append([arr1[2*(i-1)], arr1[2*(i-1) + 1]])
  end
  arr2
end

def my_to_str(arr)
  result = ''
  arr.each do |row|
    row.each do |elem|
      result += elem.to_s + ' '
    end
  end
  result
end


class CalcController < ApplicationController
  def input
  end

  def showzap
    db_records = Answer.all
    @arr_res = []
    db_records.each do |record|
      record.result == 'Ошибка ввода' || record.result == 'Взаимно-дружественные числа в диапазоне от 0 до ' + record.n.to_s + ' не найдены' ? @arr_res.append([record.result, record.n]) : @arr_res.append([my_to_arr(record.result), record.n])
    end
  end

  def view

    is_record_found = false
    db_records = Answer.all
    db_records.each do |record|
      if record.n == params[:n].to_i
        @result = (record.result == 'Ошибка ввода' || record.result == 'Взаимно-дружественные числа в диапазоне от 0 до ' + params[:n] + ' не найдены' ? record.result : my_to_arr(record.result))
        is_record_found = true
        @sources = 'DATABASE'
      end
    end
    unless is_record_found
      @sources = 'CALC'
      is_error = false
      @result =[]
      if !params[:n].is_a?(String) || params[:n].empty? || params[:n].to_i > 20000
        is_error = true
      end
      if !is_error
        (1..params[:n].to_i).each do |x|
          if exists_mutually_friendly(x, params[:n].to_i) then @result.push([x > sum_of_div(x) ? sum_of_div(x) : x, x > sum_of_div(x) ? x : sum_of_div(x)])
          end end
        @result = @result.uniq.empty? ? 'Взаимно-дружественные числа в диапазоне от 0 до ' + params[:n] + ' не найдены' : @result.uniq
      else @result = 'Ошибка ввода' end
      record_to_save = Answer.new(n: params[:n].to_i, result: @result.is_a?(String) ? @result : my_to_str(@result))
      record_to_save.save
    end
  end
end
