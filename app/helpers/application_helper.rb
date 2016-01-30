module ApplicationHelper
  def add_active?(test_path)
    return 'active' if request.path == test_path
  end

  def owns_content?(content_name)
    current_user.id == content_name.user.id
  end
end
