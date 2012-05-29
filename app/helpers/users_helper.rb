module UsersHelper

	def gravatar_for(user, options = { :size => 96 })
		id = Digest::MD5.hexdigest(user.email)
		url = 'http://0.gravatar.com/avatar/' + id + '.jpg?s=' +
      options[:size].to_s + '&d=identicon'
		size = options[:size]
		options.delete :size
		options.each {|k,v| url += "&#{k}=#{v}" unless v.nil?}
		options[:width] = options[:height] = size
		options[:alt] = user.name
		image_tag url, options
	end
end
