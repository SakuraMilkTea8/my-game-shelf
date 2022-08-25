class ShelfGamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    return true
  end

  def update?
    return true
  end

  def destroy?
    return true
  end
end
