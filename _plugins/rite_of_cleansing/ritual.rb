#Jekyll::External.require_with_graceful_fail 'htmlbeautifier'
#require 'htmlbeautifier'

module Jekyll
  module RiteOfCleansing
    class Ritual
      HERETICAL_FILETYPE = '.html'

      attr_reader :logger

      def initialize(logger)
        @logger = logger
        @logger.debug("The Machine Spirit has allowed a #{self.class} to be invoked")
      end

      def perform(file)
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      protected

      def cleanse(uncleansed_html)
        RiteOfCleansing::HtmlBeautifier.beautify(uncleansed_html)
      end

    end
  end
end
