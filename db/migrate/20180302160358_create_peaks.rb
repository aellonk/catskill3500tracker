class CreatePeaks < ActiveRecord::Migration
  def change
  	create_table :peaks do |t|
  		t.string :name
  		t.integer :elevation
  		t.date :date_hiked
  		t.string :remarks
  	end
  end
end
