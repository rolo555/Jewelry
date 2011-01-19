module ActiveScaffold
  module Helpers
    module ListColumnHelpers
      def active_scaffold_column_paperclip(column, record)
        paperclip = record.send("#{column.name}")
        unless paperclip.file?
          image_tag(paperclip.url, :border => 0)
        end
        content = if paperclip.styles.include?(PaperclipBridgeHelpers.thumbnail_style)
          image_tag(paperclip.url(PaperclipBridgeHelpers.thumbnail_style), :border => 0)
        else
          paperclip.original_filename
        end
        link_to(content, paperclip.url, :popup => true)
      end
    end
  end
end