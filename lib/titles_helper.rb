module TitlesHelper
  def t_t(key)
    scope = [:titles, :controllers]
    scope += params[:controller].split('/')
    scope << params[:action]

    t(key, :scope => scope)
  end
end
