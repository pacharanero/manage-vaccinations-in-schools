# frozen_string_literal: true

class AddConsentToNotifyLogEntries < ActiveRecord::Migration[8.1]
  def change
    add_reference :notify_log_entries,
                  :consent,
                  null: true,
                  foreign_key: true,
                  index: true
  end
end
