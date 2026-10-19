require_relative '../../support/assertions'
require_relative '../../../tools/generate-krowa-nouns'
include GameRoomTest::Assertions

result = GameRoomNounGenerator.run(check: true)
assert_equal(85_059, result[:entries])
source = File.read(File.join(GameRoomNounGenerator::ROOT, 'tools/data/krowa_nouns.txt'), encoding: 'UTF-8')
lines = source.lines
additions = %w[łam zacios zaciosy prosię silnia silnie afro szmat ksero
  szamanka szamanki sokownik sokowniki geomanta geomantka geomanci geomantki
  mop mopy bus busy pub puby tarta tarty świrus świrusy świruska świruski
  cytacik cytaciki owocek owocki token tokeny geomancje geomancja
  nekromanta nekromanci nekromantka nekromantki nekromancja nekromancje
  ranking rankingi odsłona odsłony billing billingi kasting kastingi
  halling hallingi hosting hostingi leasing leasingi lifting liftingi
  ścierak ścieraki roaming roamingi szpring szpringi pluszak pluszaki oscypek oscypki]
new_additions = %w[limonka limonki elfka elfowie elfki krasnolud krasnoludka krasnoludowie
  ork orkowie goblin goblinka gobliny goblinki ogr ogrzyca
  ogry ogrzyce gnomka gnomki niziołek niziołka niziołkowie niziołki
  satyrowie faunowie wampirzyca wampirzyce żywiołak żywiołaki golem golemy
  smoczyca smoczyce wiwerna wiwerny piksel piksele klastry parser
  parsery interpreter interpretery emulator emulatory interfejs interfejsy repozytorium
  repozytoria hiperłącze hiperłącza aplet aplety widżet widżety enkoder
  enkodery iterator iteratory rekurencja rekurencje permutacja permutacje kwantyl
  kwantyle wariancja wariancje fraktal fraktale mikroprocesor regulator regulatory
  transponder transpondery przekaźnik przekaźniki siłownik siłowniki tomograf tomografy
  hadron hadrony nukleotyd nukleotydy piroliza pirolizy grafen grafeny
  synapsa synapsy rybosom rybosomy lizosom lizosomy peroksysom peroksysomy
  mitochondrium chromatyda chromatydy polipeptyd polipeptydy genom genomy allel
  allele patogen patogeny mikrobiom mikrobiomy symbiont symbionty supernowa
  supernowe spektrogram spektrogramy tomogram tomogramy]
assert_equal(117, new_additions.length)
words = lines.map(&:chomp)
assert_equal(words.uniq, words)
(additions + new_additions).each { |word| assert_equal(1, words.count(word)) }
assert_equal(GameRoomNounGenerator.render("word\nwords\n"), GameRoomNounGenerator.render("word\nwords\n"))
assert_raises(RuntimeError) { GameRoomNounGenerator.render("KROWA_NOUNS\n") }
[" KROWA_NOUNS\n", "\tKROWA_NOUNS\n", " \t\n"].each do |text|
  assert_raises(RuntimeError) { GameRoomNounGenerator.render(text) }
end

puts 'PASS Krowa noun source provenance, stable generation and heredoc validation'
