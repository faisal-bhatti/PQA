module TasksHelper
  def get_developers
    d = User.find_all_by_user_type("Developer")
    @developers = d && d.map { |a| [a.email, a.id] }
  end


end
