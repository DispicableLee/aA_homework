require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end
# ============== play class
class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT *
      FROM plays
      WHERE title = ?
    SQL
    return nil unless play.length > 0

    Play.new(play.first) # play is stored in an array!
  end

  def self.find_by_playwright(name)
    playwright = Playwright.find_by_name(name)
    raise "#{name} not found in DB" unless playwright

    plays = PlayDBConnection.instance.execute(<<-SQL, playwright.id)
      SELECT
        *
      FROM
        plays
      WHERE
        playwright_id = ?
    SQL

    plays.map { |play| Play.new(play) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end
end


# ========= playwright class
class Playwright
  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_name(name)
    person = PlayDBConnection.instance.execute(<<-SQL, name)
      select *
      from playwrights
      where name = name
    SQL
    return nil if person.length==0
    Playwright.new(person.first)
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birthyear = options['birthyear']
  end


  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birthyear)
      INSERT INTO
        playwrights (name, birthyear)
      VALUES
        (?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end


  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birthyear, self.id)
      UPDATE
        playwrights
      SET
        name = ?, birthyear = ?
      WHERE
        id = ?
    SQL
  end



  def get_plays(name)
    raise "#{self} not in database" unless self.id
    plays = PlayDBConnection.instance.execute(<<-SQL, self.id)
      SELECT * 
      from plays
      where playwright_id = ?
    SQL
    plays.map { |play| Play.new(play) }
  end





end