class Ability
  include CanCan::Ability


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities

      def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)

  if user.role? :admin
    can :manage, :all


  elsif user.role? :instructor
    can :update, Instructor do |instructor|  
      # puts instructor.inspect
      instructor.id == user.instructor_id
    end
    can :edit, Instructor do |instructor|  
      instructor.id == user.instructor_id
    end
    can :read, Instructor do |instructor|  
      instructor.id == user.instructor_id
    end

    can :read, Student do |student|
      this_camp = user.instructor.camp_instructors.map(&:camp_id)
      student_camps = student.registrations.map(&:camp_id)
      legal = false
      for i in student_camps
        for j in this_camp
          if i == j
            legal = true
          end
        end
      end
      legal
    end

    can :read, Camp 

    can :read, Curriculum



    #User's ability
    can :create, User

    can :read, User do |u|
      u.id == user.id
    end

    can :edit, User do |u|
      u.id == user.id
    end

    can :update, User do |u|
      u.id == user.id
    end

  else
    can :read, Camp
    can :read, Curriculum
    can :read, Location
  end

end







end
