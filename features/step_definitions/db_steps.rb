Given(/^(?:the )database is empty$/) { PgTasks.truncate_tables }

Given(/^settings exist$/) { FactoryGirl.create(:setting) unless Setting.first }
