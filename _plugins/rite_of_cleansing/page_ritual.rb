#require 'ritual'

module Jekyll
  module RiteOfCleansing
    class PageRitual < Jekyll::RiteOfCleansing::Ritual

      def initialize(logger)
        super
      end

      def perform(page)
        if page.output_ext === HERETICAL_FILETYPE
          @logger.debug('Cleansing Spirit:', page.name)
          page.output = self.cleanse(page.output)
        end
      end

    end
  end
end

