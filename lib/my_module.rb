module MyModule
  def self.included(klass)
    klass.extend ModuleClassMethods
    klass.class_eval do
      scope :existing_village, -> { where(name: "Mawasa") }
      scope :trashed_village, -> { where(name: "Jadla") }
    end

    klass.instance_eval do
      scope :existing_village1, -> { where(name: "Mawasa") }
      scope :trashed_village1, -> { where(name: "Jadla") }
    end
  end

  def module_instance_method
    puts"======Hello this is instance method======"
  end

  module ModuleClassMethods
    def b1
      puts "class metthodss"
    end
  end
end