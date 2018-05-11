module ApplicationHelper
  def gravatar_for(user, options = {size: 80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    img_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    return image_tag(img_src, alt: user.username, class: "img-circle")
  end
end
