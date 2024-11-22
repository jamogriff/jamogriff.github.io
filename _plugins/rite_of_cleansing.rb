#require 'rite_of_cleansing/page_ritual'
#require 'rite_of_cleansing/document_ritual'
require 'pry'

module Jekyll
  module RiteOfCleansing
    autoload :Ritual, 'rite_of_cleansing/ritual'
    autoload :HtmlBeautifier, 'htmlbeautifier'

    attr_reader :page_ritual, :document_ritual

    def self.manifest_page_ritual()
      @page_ritual ||= PageRitual.new(Jekyll.logger)
    end

    def self.manifest_document_ritual()
      @document_ritual ||= DocumentRitual.new(Jekyll.logger)
    end
  end
end

Jekyll::Hooks.register :pages, :post_render do |page|
  ritual = Jekyll::RiteOfCleansing.manifest_page_ritual()
  ritual.perform(page);
end

Jekyll::Hooks.register :documents, :post_render do |doc|
  ritual = Jekyll::RiteOfCleansing.manifest_document_ritual()
  ritual.perform(doc)
end

