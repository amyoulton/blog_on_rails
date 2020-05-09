# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.is_admin?
        can :manage, :all
      end
    
    
    alias_action :create, :read, :update, :destroy, to: :crud

    can(:crud, Post) do |post| 
      post.user == user 
    end
    
    can(:crud, Comment) do |comment|
      comment.user == user 
    end

    can(:crud, User) do |user|
      user == user
    end
  end
end
