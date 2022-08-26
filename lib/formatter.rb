module Twine
    module Formatters
        class Flutter < Abstract
            def format_name
                'flutter'
            end
            
            def extension
                '.arb'
            end
            
            def default_file_name
                'app.arb'
            end
            
            def determine_language_given_path(path)
                match = /^.+_([^-]{2})\.arb$/.match File.basename(path)
                return match[1] if match
                
                return super
            end
            
            def read(io, lang)
                require "json"
                
                json = JSON.load(io)
                json.each do |key, value|
                    if key == "@@locale"
                        # Ignore because it represents the file lang
                    elsif key[0,1] == "@"
                        if value["description"]
                            set_comment_for_key(key[1..-1], value["description"])
                        end
                    else
                        set_translation_for_key(key, lang, value)
                    end
                end
            end
            
            def format_file(lang)
                result = super
                return result unless result
                "{\n    \"@@locale\": \"#{lang}\",\n\n#{super}\n}"
            end
            
            def format_sections(twine_file, lang)
                sections = twine_file.sections.map { |section| format_section(section, lang) }
                sections.delete_if(&:empty?)
                sections.join(",\n\n")
            end
            
            def format_section_header(section)
                "\n"
            end
            
            def format_section(section, lang)
                definitions = section.definitions.dup
                
                definitions.map! { |definition| format_definition(definition, lang) }
                definitions.compact! # remove nil definitions
                definitions.join(",\n")
            end

            def format_definition(definition, lang)
                [format_key_value(definition, lang), format_comment_and_placeholders(definition, lang)].compact.join(",\n")
            end
            
            def key_value_pattern
                "    \"%{key}\": \"%{value}\""
            end

            def format_comment_and_placeholders(definition, lang)
                placeholdersScan = definition.translation_for_lang(lang).scan(/{[a-zA-Z0-9\-\_\.]+}/m)
                if definition.comment || !placeholdersScan.empty?
                    comment = "        \"description\": \"#{definition.comment}\"" if definition.comment
                    placeholders = placeholdersScan.map! { |placeholder| "            \"#{placeholder.tr('{}','')}\": {}" }.join(",\n") if !placeholdersScan.empty?
                    placeholdersBlock = "        \"placeholders\": {\n#{placeholders}\n        }" if placeholders
                    return "    \"@#{definition.key}\": {\n#{[comment, placeholdersBlock].compact.join(",\n")}\n    }"
                end
            end
            
            def format_key(key)
                escape_quotes(key)
            end
            
            def format_value(value)
                escape_quotes(value)
            end
        end
    end
end