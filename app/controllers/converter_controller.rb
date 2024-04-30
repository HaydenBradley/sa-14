require 'httparty'

class ConverterController < ApplicationController
  def index
  end
  
  def convert
    @source_currency = params[:source_currency]
    @target_currency = params[:target_currency]
    @amount = params[:amount].to_f
    api_key = '70861411-2e50-48d1-b34b-7219aacc1668'  

    url = "https://open.er-api.com/v6/latest/#{@source_currency}"

    response = HTTParty.get(url)
    puts "Response: #{response.inspect}" 

    if response.success?
      data = JSON.parse(response.body)
      puts "Data: #{data.inspect}" 

      if data.key?('rates') && data['rates'].key?(@target_currency)
        @exchange_rate = data['rates'][@target_currency].to_f
        @converted_amount = @amount * @exchange_rate
      else
        flash[:alert] = "Exchange rate not available for the selected currencies."
        redirect_to root_path
        return
      end
    else
      flash[:alert] = "Failed to fetch exchange rates from the API."
      redirect_to root_path
      return
    end

    render :index
  end
end
