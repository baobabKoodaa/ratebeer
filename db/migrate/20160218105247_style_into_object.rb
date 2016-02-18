class StyleIntoObject < ActiveRecord::Migration
  def change

    # Uudelleennimeä vanha style
    change_table :beers do |b|
      b.rename :style, :stylename
    end

    # Luo Style -objekti
    create_table :styles do |s|
      s.string :name
      s.text :description

      s.timestamps null: false
    end

    # Liitä uusi Style Beeriin
    change_table :beers do |b|
      add_reference :beers, :style, foreign_key: true
    end

    # Käy beer-oliot läpi ja liitä oldStyleä vastaavaan styleen, tarvittaessa luo stylet
    Beer.all.each do |beer|
      if beer.style.nil?
        lol = Style.find_by name: (beer.stylename)
        if lol.nil?
          lol = Style.create(name: beer.stylename, description: "Kuvaus")
        end
        beer.style = lol
        beer.save
      end
    end

    # Poista vanha style
    change_table :beers do |b|
      remove_column :beers, :stylename
    end
  end
end
