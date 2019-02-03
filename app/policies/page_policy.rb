class PagePolicy <  ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def edit?
    user == record.user || admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

  def recover?
    true
  end

  def send_recovery_email?
    true
  end
end
