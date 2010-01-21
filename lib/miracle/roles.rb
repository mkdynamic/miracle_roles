module Miracle
  module Roles

    def self.included(base)
      base.class_eval do
        serialize :roles

        def self.define_roles(*roles)
          @@defined_roles = roles
          @@defined_roles.each do |role|
            class_eval %{
              def #{role}?
                self.roles.include?(:#{role})
              end

              # HAXX: Not the best code ever written...
              named_scope :#{role.to_s.pluralize}, 
                          :conditions => ['roles LIKE ?', "%\n-\s:#{role}\n%"]
            }
          end
        end

        def self.defined_roles
          @@defined_roles
        end
      end
    end

    # NOTE: This may break something if it's already defined in the including class
    # ...or if it's redefined later
    def after_initialize
      self.roles ||= []
    end

    def add_role(role)
      role = role.to_sym
      validate_role! role
      self.roles << role
      self.roles.uniq!
    end

    def remove_role(role)
      self.roles.reject! { |r| r == role.to_sym }
    end

    def roles=(list)
      list = list.reject(&:blank?).map { |r| r.to_sym }.reject { |r| !valid_role?(r) }
      write_attribute(:roles, list.uniq)
    end

    # for declarative_authorization support
    def role_symbols
      self.roles
    end

  private

    def validate_role!(role)
      raise "Unknown role!" unless valid_role?(role)
    end

    def valid_role?(role)
      self.class.defined_roles.include?(role)
    end

  end  
end