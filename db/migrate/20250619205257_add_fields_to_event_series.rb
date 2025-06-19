class AddFieldsToEventSeries < ActiveRecord::Migration[7.2]
  def change
    add_reference :event_series, :community, null: false, foreign_key: true
    add_reference :event_series, :site, null: false, foreign_key: true
    add_column :event_series, :date, :date
    add_column :event_series, :day_of_week, :string
    add_column :event_series, :time, :time
    add_column :event_series, :category, :string
    add_column :event_series, :description, :text
  end
end
