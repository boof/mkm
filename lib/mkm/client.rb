module Mkm
  class Client < Struct.new(:agent)

    def games
      agent.get("games")['game'].
        each {|g| g['id'] = g.delete('idGame') }
    end

    def card_by_name(name, game_id=1, language_id=1)
      product(name, game_id, language_id, true)
    end

    def search(name, game_id=1, language_id=1)
      product(name, game_id, language_id, false)
    end

    private

      def product(name, game_id, language_id, search)
        clean_name = URI.escape(name.gsub(/[^a-zA-Z0-9 ]/, '').downcase)
        path = ["products", clean_name, game_id, language_id, search].join("/")

        agent.get(path)['product']
      end

  end
end
