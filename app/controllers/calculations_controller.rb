class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    textarray = @text.split;

    @word_count = textarray.count;

    @character_count_with_spaces = @text.length;

    newtext = @text.gsub(" ", "")

    @character_count_without_spaces = newtext.length

    count = 0
    textarray.each do |word|
      if word.downcase.gsub(/[^\w]/i, "") == @special_word.downcase
        count += 1
      end
    end

    @occurrences = count

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f


    month = @years * 12;
    effectiveapr = (@apr/100)/12;

    payment = @principal * (effectiveapr / (1-(1+effectiveapr)**-month))

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = payment

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    minnum = @numbers[0]
    maxnum = @numbers[0]
    count = @numbers.count
    sortedarray = @numbers.sort
    sum = @numbers.sum
    mean = sum / count
    varsum = 0.0

    @numbers.each do |num|
      if num < minnum
        minnum = num
      end

      if num > maxnum
        maxnum = num
      end

      varsum = varsum + (num - mean)**2.0

    end

    var = varsum / count

    if @numbers.count % 2 == 0
      upper = (@numbers.count / 2).to_i
      lower = upper-1
      median = (sortedarray[lower] + sortedarray[upper]) / 2
    else
      middle = (@numbers.count / 2).to_i
      median = sortedarray[middle]
    end

    @sorted_numbers = sortedarray

    @count = count

    @minimum = minnum

    @maximum = maxnum

    @range = maxnum - minnum

    @median = median

    @sum = sum

    @mean = mean

    @variance = var

    @standard_deviation = var**(0.5)

    @mode = "How the fuck do I do this"

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
