class AddSocialColumnsToUser < ActiveRecord::Migration
  def change
    # add_column :users, :facebook, :string
    add_column :users, :f_uid, :string
    add_column :users, :f_access_token, :string
    # add_column :users, :provider, :string
    add_column :users, :g_uid, :string
    add_column :users, :g_access_token, :string
    add_column :users, :t_uid, :string
    add_column :users, :t_access_token, :string

    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :gender, :string
    add_column :users, :dob, :datetime
    add_column :users, :occupation, :string
    add_column :users, :street_addr, :string
    add_column :users, :post_code, :string
    add_column :users, :region, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
  end
end
