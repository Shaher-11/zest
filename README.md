clauses = [
  { "id" => 1, "text" => 'The quick brown fox' },
  { "id" => 2, "text" => 'jumps over the lazy dog' },
  { "id" => 3, "text" => 'And dies' },
  { "id" => 4, "text" => 'The white horse is white' }
  ]

  sections = [
    { "id" => 1, "clauses_ids" => [1, 2, nil] }
  ]

class Generator

  def generate_from_clause(clus)
    puts "A T&C Document

  This document is made of plaintext."
    clus.each do |i|
      if i.key?("text")
        puts "Is made of " << i["text"]
      end 
    end 
    puts "Your legals."
  end 

  def generate_from_section(cls, sec)
    puts "A T&C Document

    This document is made of plaintext."
    sec.each do |h|
      h["clauses_ids"].compact.each do |d|
        cls.each do |c|
          if c["id"] == d && c.key?("text")
          puts  "Is made of " << c["text"]
          end
        end
      end
    end
    puts "Your legals."
  end 
end 

result = Generator.new

# result.generate_from_clause(clauses)
############## Output #####################
# A T&C Document

#  This document is made of plaintext.
# Is made of The quick brown fox
# Is made of jumps over the lazy dog
# Is made of And dies
# Is made of The white horse is white
# Your legals.


result.generate_from_section(clauses, sections)
############# Output ###########################
# A T&C Document

# This document is made of plaintext.
# Is made of The quick brown fox
# Is made of jumps over the lazy dog
# Your legals.
