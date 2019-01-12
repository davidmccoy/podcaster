class UserPolicy <  ApplicationPolicy
  def show?
    user == record || admin?
  end

  def edit?
    show?
  end

  def update?
    show?
  end
end
