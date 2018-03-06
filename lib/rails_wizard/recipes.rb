module RailsWizard
  module Recipes
    @@excluded_recipes = ["example"]
    @@categories = {}
    @@list = {}
    @@descriptions = {}

    def self.add(recipe)
      RailsWizard::Recipes.const_set ActiveSupport::Inflector.camelize(recipe.key), recipe
      return if @@excluded_recipes.include? recipe.key
      @@list[recipe.key] = recipe
      (@@categories[recipe.category.to_s] ||= []) << recipe.key
      @@categories[recipe.category.to_s].uniq!
      @@descriptions[recipe.key] = recipe.description
      recipe
    end

    def self.clear
      self.list.each do |recipe_key|
        send(:remove_const, ActiveSupport::Inflector.camelize(recipe_key))
      end
      @@categories = {}
      @@list = {}
    end

    def self.[](key)
      @@list[key.to_s]
    end

    def self.list
      @@list.keys.sort
    end

    def self.list_classes
      @@list.values.sort_by{|c| c.key}
    end

    def self.categories
      # move 'apps' to last position
      @@categories.keys.sort { |x,y| y  == "apps" ? -1 : x <=> y }
    end

    def self.description_for(recipe)
      @@descriptions[recipe.to_s]
    end

    def self.for(category)
      (@@categories[category.to_s] || []).sort
    end

    def self.remove_from_category(category, recipe)
      (@@categories[category.to_s] ||= []).delete(recipe.key)
    end

    def self.add_from_directory(directory)
      Dir.foreach(directory) do |file|
        path = File.join(directory, file)
        next unless path.match /\.rb$/
        key = File.basename(path, '.rb')
        recipe = Recipe.generate(key, File.open(path))
        add(recipe)
      end
    end
  end
end
