# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.
require 'csv'
require_relative '../config/environment.rb'

class Daily_Show
  @@all = []
  attr_accessor :year, :googleknowledge_occupation, :show, :group, :raw_guest_list

  def initialize(attributes)
    @id = nil
    attributes.each {|key, value| self.send("#{key}=", value) }
    @@all << self
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS daily_show_guests (
        id INTEGER PRIMARY KEY,
        year INTEGER,
        googleknowledge_occupation TEXT,
        show TEXT,
        gr TEXT,
        raw_guest_list TEXT
      )
      SQL
    DB[:conn].execute(sql)
  end

  def self.create(attributes)
    daily_show = Daily_Show.new(attributes)
    
  end

  def save
    sql = <<-SQL
      INSERT INTO daily_show_guests (year, googleknowledge_occupation, show, gr, raw_guest_list)
      VALUES (?,?,?,?,?)
    SQL

    DB[:conn].execute(sql, self.year, self.googleknowledge_occupation, self.show, self.group, self.raw_guest_list)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM daily_show_guests")[0][0]
  end
end



table = CSV.read("./daily_show_guests.csv",
headers: true);

Daily_Show.create_table


table.each do |row|
  attributes = {
    year: row["YEAR"],
    googleknowledge_occupation: row["GoogleKnowlege_Occupation"],
    show: row["Show"],
    group: row["Group"],
    raw_guest_list: row["Raw_Guest_List"]
  }
  daily_show = Daily_Show.new(attributes);
  daily_show.save;
end
