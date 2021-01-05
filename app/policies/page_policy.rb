class PagePolicy <  ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def upload?
    true
  end

  def edit?
    user == record.user || admin?
  end

  def settings?
    edit?
  end

  def update?
    edit?
  end

  def delete?
    edit?
  end

  def destroy?
    edit?
  end

  def audience?
    edit?
  end

  def downloads?
    edit?
  end

  def episodes?
    edit?
  end

  def devices?
    edit?
  end

  def platforms?
    edit?
  end

  def referrers?
    edit?
  end

  def countries?
    edit?
  end

  def recover?
    true
  end

  def send_recovery_email?
    true
  end
end
