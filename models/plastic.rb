require_relative( '../db/sql_runner' )

class Plastic
  attr_reader :id
  attr_accessor :type, :existance, :weight

def initialize( options )
  @id = options['id'].to_i if options['id']
  @type = options['type']
  @existance = options['existance'].to_i
  @weight = options['weight'].to_i
end
