#require 'ritual'

module Jekyll
  module RiteOfCleansing
    class DocumentRitual < Jekyll::RiteOfCleansing::Ritual

      def initialize(logger)
        super
      end

      def perform(page)
        if document.output_ext === HERETICAL_FILETYPE
          Jekyll.logger.debug('Cleansing Spirit:', document.relative_path)
          document.output = self.cleanse(document.output)
        end
      end

    end
  end
end

