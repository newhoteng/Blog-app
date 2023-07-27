class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    # Define abilities for a regular user
    can :destroy, Post, author_id: user.id
    can :destroy, Comment, user_id: user.id
    # Define abilities for an admin user
    return unless user.role == 'admin'

    can :destroy, Post
    can :destroy, Comment
  end
end
