class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :title, false
  end
end
