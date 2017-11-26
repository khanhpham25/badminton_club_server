class RenameRequestsToJoinRequests < ActiveRecord::Migration[5.1]
  def change
    rename_table :requests, :join_requests
  end
end
