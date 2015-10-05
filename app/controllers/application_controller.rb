class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || properties_path(city: session[:city])
    end
  end

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    route = Rails.application.routes.recognize_path(request.referer)
    if "#{route[:controller]}_controller".camelize.constantize.ancestors.find { |f| f == DeviseController }
      super # subclass of devise --> handle redirect by devise
    else
      callbacks = "#{route[:controller]}_controller".camelize.constantize._process_action_callbacks
      filtered =callbacks.select{|f| f.filter == :authenticate_user! && f.instance_values["if"][0].include?(route[:action]) }
      if !filtered.blank? # can not access by public --> to root_path
        root_path
      else
        request.referer # redirect back
      end
    end
  end

end
