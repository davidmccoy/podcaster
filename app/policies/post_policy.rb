class PostPolicy <  ApplicationPolicy
  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    @user == record.page.user || admin?
  end

  def show?
    @user == record.page.user || admin? || record.publish_time < Time.zone.now
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
