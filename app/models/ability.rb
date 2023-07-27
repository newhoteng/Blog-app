class Ability
  include CanCan::Ability

  # def initialize(user)
  #   can :read, Post, public: true

  #   return unless user.present?  # additional permissions for logged in users (they can read their own posts)
  #   can :read, Post, user: user

  #   return unless user.admin?  # additional permissions for administrators
  #   can :read, Post
  # end

  # <% if can? :read, @post %>
  #   <%= link_to "View", @post %>
  # <% end %>

  # <% if can? :destroy, @comment %>
  #   <%= link_to "Delete", comment_path(@comment), method: :delete, data: { confirm: "Are you sure?" } %>
  # <% end %>

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
