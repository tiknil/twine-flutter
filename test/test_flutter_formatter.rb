require 'minitest/autorun'
require 'twine-flutter'

class TestFlutterFormatter < Minitest::Test
    def setup
        formatter = Twine::Formatters::Flutter.new
        formatter.twine_file = Twine::TwineFile.new
        formatter.options = { consume_all: true, consume_comments: true }
    end

    def test_twine_to_arb
        assert true #TODO
    end

    def test_arb_to_twine
        assert true #TODO
    end
end