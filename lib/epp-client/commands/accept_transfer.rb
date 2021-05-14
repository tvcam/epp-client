require File.expand_path('../command', __FILE__)

module EPP
  module Commands
    class AcceptTransfer < Command
      NAMESPACE = 'http://www.nominet.org.uk/epp/xml/std-handshake-1.0'
      SCHEMA_LOCATION = 'http://www.nominet.org.uk/epp/xml/std-handshake-1.0 std-handshake-1.0.xsd'

      def initialize(case_id)
        @case_id = case_id
      end

      def name
        'update'
      end

      def to_xml
        @namespaces ||= {}

        node = super
        node << accept_node
        node
      end

      private

      def accept_node
        node = xml_node('accept')
        node.namespaces.namespace = accept_namespace(node)
        node << xml_node('h:caseId', @case_id)
        node
      end

      def accept_namespace(node)
        return @namespaces['h'] if @namespaces.has_key?('h')
        @namespaces['h'] = xml_namespace(node, 'h', NAMESPACE)
      end

      def case_id_node
        node = xml_node('h:caseId')
        node.namespaces.namespace = accept_namespace(node)
      end
    end
  end
end
