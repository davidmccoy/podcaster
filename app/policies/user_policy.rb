class UserPolicy <  ApplicationPolicy
  def show?
    user || admin?
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  def password?
    user || admin?
  end

  def update_password?
    password?
  end
end
