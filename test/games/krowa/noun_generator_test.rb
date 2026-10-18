require_relative '../../support/assertions'
require_relative '../../../tools/generate-krowa-nouns'
include GameRoomTest::Assertions

result = GameRoomNounGenerator.run(check: true)
assert_equal(98_315, result[:entries])
source = File.read(File.join(GameRoomNounGenerator::ROOT, 'tools/data/krowa_nouns.txt'), encoding: 'UTF-8')
lines = source.lines
assert_equal('5e9e97a7681e662e97527a794846f965a0b789e1f47b3c06c5fc8404490d0389', Digest::SHA256.hexdigest(lines.first(98_178).join))
additions = %w[łam zacios zaciosy prosię silnia silnie afro szmat ksero
  szamanka szamanki sokownik sokowniki geomanta geomantka geomanci geomantki
  mop mopy bus busy pub puby tarta tarty świrus świrusy świruska świruski
  cytacik cytaciki owocek owocki token tokeny geomancje geomancja
  nekromanta nekromanci nekromantka nekromantki nekromancja nekromancje
  ranking rankingi odsłona odsłony billing billingi kasting kastingi
  halling hallingi hosting hostingi leasing leasingi lifting liftingi
  ścierak ścieraki roaming roamingi szpring szpringi pluszak pluszaki oscypek oscypki]
assert_equal(additions, lines.drop(98_178).first(additions.length).map(&:chomp))
new_additions = %w[wyjec wyjce oktagon oktagony pentagon pentagony żyrantka żyrantki
  logistyk logistycy meleks meleksy biorytm biorytmy pozorant pozoranci
  pozorantka pozorantki pangram pangramy kebab kebaby balik baliki kamerka
  kamerki guru abnegatka abnegatki karpatka karpatki makiełka makiełki
  woliera woliery frykas okruch kampus kampusy guziec guźce baniak baniaki
  miruna miruny wątpia marker markery burger burgery granola granole
  spalarnia spalarnie rolkarz rolkarze rolkarka rolkarki polar polary koran
  tora lokum login prompter promptery neutrino neutrina]
assert_equal(68, new_additions.length)
assert_equal(new_additions, lines.drop(98_247).map(&:chomp))
words = lines.map(&:chomp)
(additions + new_additions).each { |word| assert_equal(1, words.count(word)) }
assert_equal(GameRoomNounGenerator.render("word\nwords\n"), GameRoomNounGenerator.render("word\nwords\n"))
assert_raises(RuntimeError) { GameRoomNounGenerator.render("KROWA_NOUNS\n") }
[" KROWA_NOUNS\n", "\tKROWA_NOUNS\n", " \t\n"].each do |text|
  assert_raises(RuntimeError) { GameRoomNounGenerator.render(text) }
end

puts 'PASS Krowa noun source provenance, stable generation and heredoc validation'
