class UsersController < ApplicationController
  def loginpage
  end

  def login
    user = User.where(email: params[:email])[0]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else @user
      flash[:login_error] = "Invalid combination"
      redirect_to "/"
    end
  end

  def registration_page
  end

  def register  
    user = User.new(params.permit(:first_name, :last_name, :password, :password_confirmation, :email, :wild_id))
    puts user.inspect
    if user.save
      session[:user_id] = user.id
      redirect_to '/dashboard'
    else
      flash[:errors] = {errors: user.errors.full_messages}
      puts user.errors.full_messages
      redirect_to '/registration_page'
    end
  end

  def dashboard
    @user_info = User.find(session[:user_id])
  end

  def summary
    user_date_and_counts = User.find(session[:user_id]).catchcards.group('DATE(created_at)').count('created_at').to_a 
    user_catch_info = User.find(session[:user_id]).catchcards

    obj = {
      "user_date_and_counts" => user_date_and_counts,
      "user_catch_info" => user_catch_info
    }

    render json: obj
  end

  def fish_date_count
    user_catch_info = Catchcard.where(user:User.find(session[:user_id])).where('created_at BETWEEN ? AND ?', params[:date]+" 00:00:00 UTC", params[:date]+" 23:59:59 UTC")
    user_date_and_counts = User.find(session[:user_id]).catchcards.group('DATE(created_at)').count('created_at').to_a

    obj = {
      "user_date_and_counts" => user_date_and_counts,
      "user_catch_info" => user_catch_info
    }


    render json: obj
  end


  def submitfishes
    puts "in submit fishes "*1000

    puts params.inspect

    params[:_json].each do |element|
      puts element[:fish]
      Catchcard.create(user:User.find(session[:user_id]), location:Location.where(river: element[:river]).first, fish: Fish.where(fish_type:element[:fish]).first, wild_or_hatchery: element[:type])
    end
    user_catch_info = User.find(session[:user_id]).catchcards
    obj = {
      "content" => "hi"
    }
    render json: obj
  end


end
