class ChangeClausesBooleanValueToBoolean < ActiveRecord::Migration
  def up
    change_column 'clauses', 'boolean_value', :boolean
  end

  def down
    change_column 'clauses', 'boolean_value', :integer, :limit => 1
  end
end
