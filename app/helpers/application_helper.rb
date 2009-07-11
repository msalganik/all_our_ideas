# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def logged_in?
    @controller.user_set?
  end

  def percentage(num, denom)
    @controller.percentage(num, denom)
  end

  def google_maps_key
    if @controller.request.env['SERVER_NAME'] =~ /allourideas/
      # allourideas.org
      'ABQIAAAAYF1X_Xk6WVB2CJtN2ceMNRTLCQwoxxEaAy7MVXgS8jhkwc-a1hQayD28z5vhzz9k8nBR7mUClbkciQ'
    else
      # compairwise.photocracy.org
      'ABQIAAAAYF1X_Xk6WVB2CJtN2ceMNRSiwqBVK9UCwh-neRGNZQGFqE8clRQUTXNArLqWIfILMbRsjgmsvO3XEg'
    end
  end

  def status(active)
    active ? t('common.active') : t('common.inactive')
  end

  def vote_quick_link(default)
    q = Question.first(:conditions => { :pairwise_id => @question_id } )
    q && !q.name.empty? ? @controller.named_url_for_question(q) : default
  end

  def quick_link(uri, default)
    unless @name
      q = Question.first(:conditions => { :pairwise_id => @question_id } )
      @name = q && !q.name.empty? ? q.name : true
    end
    @name == true ? default : "/#{@name}/#{uri}"
  end

  def log_or_new_path
    @controller.user_set? ? new_question_path : new_user_path
  end

  def class_for_nav(params, action, controller = 'home')
    params[:controller] == controller && params[:action] == action ? { :class => 'down' } : {}
  end

  def rounded(content, classes = "border")
    render(:partial => 'shared/rounded', :locals => { :classes => classes, :content => content })
  end

  def login_or_users_path
    @controller.user_set? ? users_path : login_path
  end
end
