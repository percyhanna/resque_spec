class NameFromClassMethod
  class << self
    attr_accessor :invocations

    def perform(*args)
      self.invocations += 1
    end

    def queue
      :name_from_class_method
    end
  end

  self.invocations = 0
end

class NameFromInstanceVariable
  @queue = "name_from_instance_variable"
end

class Person
  class << self
    attr_accessor :afters, :arounds, :befores, :enqueues, :invocations

    def after_enqueue(*args)
      self.enqueues += 1
    end

    def after_perform(*args)
      self.afters += 1
    end

    def around_perform(*args)
      self.arounds += 1
      yield *args
    end

    def before_perform(*args)
      self.befores += 1
    end

    def failures
      @failures ||= []
    end

    def on_failure(exception, *args)
      failures << exception
    end

    def perform(first_name, last_name)
      self.invocations += 1
    end

    def queue
      :people
    end
  end

  self.afters = 0
  self.arounds = 0
  self.befores = 0
  self.enqueues = 0
  self.invocations = 0
end

class Place
  class << self
    def failures
      @failures ||= []
    end

    def on_failure(exception, *args)
      failures << exception
    end

    def perform(name)
      raise "OMG!"
    end

    def queue
      :places
    end
  end
end
