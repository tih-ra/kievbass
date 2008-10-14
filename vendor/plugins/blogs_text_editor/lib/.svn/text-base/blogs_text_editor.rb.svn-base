module BlogsTextEditor
   module ClassMethods
     
     def configure_blogs_text_editor_panel(options = {})
       blogs_text_editor_options = options.delete(:options) || nil
       proc = Proc.new do |c|
         c.instance_variable_set(:@blogs_text_editor_options, blogs_text_editor_options)
       end
       before_filter(proc, options)
     end
   
   end 
   
   module LoadLanguage
     class << self
       def set lang
         value =File.open(File.dirname(__FILE__) + "/../languages.yml") { |f| YAML.load(f.read) }
         return value[lang]
       end
     end
   end
   
   def self.included(base)
     base.extend(ClassMethods)
   end
   
end