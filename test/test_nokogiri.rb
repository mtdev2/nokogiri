require "helper"

class TestNokogiri < Nokogiri::TestCase
  def test_libxml_iconv
    skip "this constant is only set in the C extension when libxml2 is used" if !Nokogiri.uses_libxml?
    assert Nokogiri.const_defined?(:LIBXML_ICONV_ENABLED)
  end

  def test_parse_with_io
    doc = Nokogiri.parse(
      StringIO.new("<html><head><title></title><body></body></html>")
    )
    assert_instance_of Nokogiri::HTML::Document, doc
  end

  def test_xml?
    doc = Nokogiri.parse(File.read(XML_FILE))
    assert doc.xml?
    assert !doc.html?
  end

  def test_atom_is_xml?
    doc = Nokogiri.parse(File.read(XML_ATOM_FILE))
    assert doc.xml?
    assert !doc.html?
  end

  def test_html?
    doc = Nokogiri.parse(File.read(HTML_FILE))
    assert !doc.xml?
    assert doc.html?
  end

  def test_nokogiri_method_with_html
    doc1 = Nokogiri(File.read(HTML_FILE))
    doc2 = Nokogiri.parse(File.read(HTML_FILE))
    assert_equal doc1.serialize, doc2.serialize
  end

  def test_nokogiri_method_with_block
    doc = Nokogiri { b "bold tag" }
    assert_equal("<b>bold tag</b>", doc.to_html.chomp)
  end

  def test_make_with_html
    doc = Nokogiri.make("<b>bold tag</b>")
    assert_equal("<b>bold tag</b>", doc.to_html.chomp)
  end

  def test_make_with_block
    doc = Nokogiri.make { b "bold tag" }
    assert_equal("<b>bold tag</b>", doc.to_html.chomp)
  end
end
