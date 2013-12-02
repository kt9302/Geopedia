module ApplicationHelper
    def full_title(page_title)
        base_title = "Geopedia"
        if page_title.empty?
            base_title
            else
            "#{page_title} | #{base_title}"
        end
    end
    def flash_class(level)
        case level
            when :notice then "info"
            when :error then "error"
            when :alert then "warning"
        end
    end
end
