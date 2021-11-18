class AddDetailsToUser < ActiveRecord::Migration
  def change
    create_table "users", force: :cascade do |t|
      t.string   "provider"
      t.string   "uid"
      t.string   "oauth_token"
      t.string   "oauth_expires_at"
    end
  end
end
