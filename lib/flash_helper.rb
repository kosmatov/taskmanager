module FlashHelper
  def f_t(key)
    scope = [:flash, :controllers]
    scope += params[:controller].split('/')
    scope << params[:action]

    t(key, :scope => scope)
  end
end
