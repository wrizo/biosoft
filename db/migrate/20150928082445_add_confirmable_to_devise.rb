class AddConfirmableToDevise < ActiveRecord::Migration
	def self.up
		add_column :users, :confirmation_token, :string
		add_column :users, :confirmed_at,       :datetime
		add_column :users, :confirmation_sent_at , :datetime
		add_column :users, :unconfirmed_email, :string

		add_index  :users, :confirmation_token, :unique => true

		#your current data will be treated as if they have confirmed their account
		User.update_all(:confirmed_at => Time.now) 

	end
	
	def self.down
		remove_index  :users, :confirmation_token

		remove_column :users, :unconfirmed_email
		remove_column :users, :confirmation_sent_at
		remove_column :users, :confirmed_at
		remove_column :users, :confirmation_token
	end

end
