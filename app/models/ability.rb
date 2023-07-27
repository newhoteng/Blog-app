# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    # Define abilities for a regular user
    can :delete, Post, author_id: user.id
    can :delete, Comment, user_id: user.id
    # Define abilities for an admin user
    if user.role == "admin"
      can :delete, Post
      can :delete, Comment
    end
  end
end
