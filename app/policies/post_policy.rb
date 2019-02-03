class PostPolicy <  ApplicationPolicy
  def show?
    true
  end

  def new?
    @user == record.page.user || admin?
  end

  def create?
    new?
  end

  def edit?
    @user == record.page.user || admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
