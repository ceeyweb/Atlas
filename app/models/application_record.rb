# Data wihthin the application can't be modifed directly (no create, save or
# delete); any data needed should be loaded by updating in the _seeds.rb_ file
# or creating a _Rake_ task.
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_destroy { raise ActiveRecord::ReadOnlyRecord }

  def delete
    destroy
  end

  def readonly?
    true
  end
end
