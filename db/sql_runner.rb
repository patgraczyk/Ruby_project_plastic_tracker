require('pg')

class SqlRunner

  def self.run(sql, values = [])
    begin
      db = PG.connect({dbname: 'dek0j6qoir6n61', host: 'ec2-54-83-22-244.compute-1.amazonaws.com
', port:5432, user:'faprqovlxwtqlh', password:'e59e430860d05e2b3bc2e0809e9c361bb9be33cf7e4d1a7fcef9cd5daca4bed6'})
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
