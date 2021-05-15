require File.expand_path('../command', __FILE__)

module EPP
  module Commands
    class TransferHandshake < Command
      NAMESPACE = 'http://www.nominet.org.uk/epp/xml/std-handshake-1.0'
      SCHEMA_LOCATION = 'http://www.nominet.org.uk/epp/xml/std-handshake-1.0 std-handshake-1.0.xsd'

      def initialize(case_id, handshake: 'accept')
        raise 'Unsupported handshack command' unless handshake.in? %w(accept reject)

        @case_id = case_id
        @handshake = handshake
      end

      def name
        'update'
      end

      def to_xml
        @namespaces ||= {}

        node = super
        node << handshake_node
        node
      end

      private

      def handshake_node
        node = xml_node(@handshake)
        node.namespaces.namespace = handshake_namespace(node)
        node << xml_node('h:caseId', @case_id)
        node
      end

      def handshake_namespace(node)
        return @namespaces['h'] if @namespaces.has_key?('h')
        @namespaces['h'] = xml_namespace(node, 'h', NAMESPACE)
      end
    end
  end
end
