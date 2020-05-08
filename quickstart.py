"""
This template is written by @Edhim

What does this quickstart script aim to do?
- I am using simple settings for my personal account with a crontab each 3H,
it's been working since 5 months with no problem.
"""

from instapy import InstaPy
from instapy import smart_run

# get a session!
session = InstaPy(username='juanma.io', password='',headless_browser=False, disable_image_load=False)
session.set_dont_include(['allysongreycosm','niimiii_hiroki','brett_flanigan','frazzeta_art_museum','_shan_jiu','siyatovska',"seshboxhq", "chuvabak_art", "alexgreycosm", "violarenate", "krasivity", "hardgraverw", "xaviceerre", "nilsjendri", "costelol", "marioweinberg", "martnbruc", "pliegue", "escueladevrock", "bicho.pablo", "caseybquiet", "elalesicumbiaok", "j44444y", "aagustinavera", "brigita_la_art", "baleksandar", "haskonee", "3mood6swings9", "alm_______a", "paulgrodhues", "hensethename", "celestin_krier", "bertadipaolo", "antonellazaro", "carolabagnato", "nyiam_", "gommaargilliams", "quetzalau", "ourisazo", "flan_jm", "takujihanga", "ferrerartstudio", "den.itram", "madre.selvaa", "lafuenteunlp", "fourtwenty", "comfortablefields", "z_e_b_u", "mrodriguezmolina", "sirenalibanesa", "lucho.montolivo", "lucampierre", "_epifita", "sabiduria.psiconauta", "pisanoagus", "zziro_one", "sofiastambuk", "danielmelloart", "g.pesoc", "bellink13", "a.creature", "ripripiest", "sebastian_peronja", "lutmi.f", "anitabelen.delsur", "santi.galarsa", "otraveznokamil", "maotik_", "jkovljevich", "rudas.producciones", "maroriolani", "thewalkingconurban", "santitagliabue", "louisedespont", "hirundoaves", "art_lobster", "mgiamello", "roice183", "blo_dmv", "vntonia.__", "dangwayneolsen", "federicocunicella", "ram__han", "veranoal2020", "lenia_hauser", "padrebio_", "juan_zurita_benedicto", "maryameivazistudio", "_gonx.musicx", "joe_warrior_walker", "funskull", "publicdomainrev", "taylorothomas", "salt_lik", "renatatrincheri", "xxhartxs", "volobevza", "0111011cnztnz", "handpokejaus", "stephenellcock", "julianpoli", "arieldavi.s", "fluff.faun", "tinchoobal", "sandroryry", "peter_fahr_junior", "skkinz", "rebu_ceramics", "empache.lp", "jhnyo", "rosh333", "katefrizalis", "theo_lopez_artist", "ceramicism", "sebasbelzagui", "robertbatyko", "3dmotionfucking", "sebastianhelling", "lino.lu", "edicionesafines", "merijnhos", "monaritmica", "gcabra_", "hagiharatakuya", "florakai_", "demsky__", "maria_lundstrom", "guby_caregnato", "truchaestudio", "jchapline", "facundomuntz", "nicholasklaw", "l.e.germann", "lx1one", "gregoruot", "post_vandalism", "kusssch", "denlopezp", "saschamissfeldt", "o_r_i____", "delcierro", "chyrumlambert", "mars_1_", "totarodriguezsouilla", "abbaiala", "martiimezzetti", "sskirl", "dani.montesi", "art_digitalogic", "0phidis", "cararcuri", "fraanolalla_", "erikparkerstudio", "martinnicolausson", "omegatbs", "lipineyro", "superficievirtual", "egavagnin", "gonzalogarciaolivares", "zoerism", "pitta_kkm", "escapescapes", "blacktot.e", "juliettediazmention", "c0nurban4", "marcosuguelli", "tenderboy_", "russell_tyler", "jean_nagai", "gonzmonzon", "qinjoa", "__asfixia__", "cami.lombar", "tenderbrusselssprout", "moyavalentina", "vladimir.houdek", "n.4.x.i", "manumondi51", "camm.avalos", "julianstimbaum", "eric.reh", "pia.nomade", "ifyouhigh", "imrichkovacs", "daisyparris", "pablotomek", "damn_zippy", "malefrangul", "r.epmac", "graffitiremovals", "dextermaurer", "diteruggi", "ammielbordon", "chiro.dannunzio", "scottifight", "matando_muros", "b0mberjacket", "camilabucar", "yeseastarloa", "emiliagomezbergna", "xojotax", "pinturabasica1y2", "valchopg", "u______________m", "trudybenson", "lucas__dupuy", "lo_milo_", "alexistouloupas", "slowdaiv", "taylor.makeuupp", "chimi.flo", "jorgelinaquinteros", "badvilx", "davidvonbahr", "clinicafda", "virtualmandi", "franciscomendesmoreira", "elliot_snowman", "esergundz", "i_am_jameslau", "nasarimba_", "julianllouve", "alfe.fm", "amordehortelano", "omze__", "moron.german18", "trashgraff", "mercedes_bonzai", "tetepitus_", "david_jien", "gusano_local", "piedraplanta", "deriksorato", "kunfuchi_", "natalia_carod", "ms_bozo", "r_a_ff_l_e_s_i_a", "luciacc0", "blaucecilieblu", "irenealdazabal", "delrio.renata", "matetorino", "micavallejospintura", "camilo__palomino", "manc0r", "enaeena_", "franklaroo", "pablogabrieldi", "karuguarinook", "victoriawaw_", "a_carrau", "mjulitoledo", "jaw_dmv", "ine.viitable", "maite.etc", "floraalonsoo", "wluisaw", "pedrobaeck", "olierlazaro", "clara.carlon", "xmealejox", "julietalayana", "rafflesiaaf", "jazminmazzu", "pablochanour", "pupialfaro", "williom.banda", "eslaruina", "caro.casanovas", "r_u_i_n_", "an.massera", "ericsall76", "delfiiiq", "konich.iwa", "giamellorf", "gabrieluan", "ruco__", "alphachanneling", "n1nn4__", "nanovls", "mora.jm", "palomapriotti", "le_bas_", "klub7_artcollective", "ayer.le.vi", "aaddisonaadams", "lu.cianuro", "virroveda", "paula_barrio8", "davorgromilovic", "kfacastagno", "delfiskywalker", "rei_vaj", "volkov.scvt", "oliviervrancken", "nuriacaimmi", "4na.pau.la_", "ritasalt", "guicabra", "antozanzottera", "scottbertram_art", "ingoalbrechthauser", "ceramicamariaflor", "soyfersantana", "energygloop", "pylarbaigorri", "87mosa87", "or_kantor", "marti.mezzetti", "girof.ink", "franciscochimi", "manuamante", "claaaribarbero", "camiloortega.zv", "82eliote", "charleypeters", "fernico18", "agustinamartin3", "cribodora", "rodrigopinto___", "saraandreasson", "moto583motohiro", "yosoyvalentino", "francisco.boronat", "_nickwilkinson_", "mikeokay", "d.o.sol3r", "luxiano31", "chinomorgante", "irenegoin", "sebagua", "jo.castroman", "masquesuerte", "lanegracarri", "marrashu", "oritoor", "meugelandia", "60n54_", "_antoantu", "_kalkov", "mafia_tabak", "christianaugust128", "heavenly_beauty_tattoo", "terry_hoff", "murgia.manuel", "mauarcuri", "naiarabadr", "ceciliavazqz", "mmorgannbblairr", "mafi.taylor", "panchito_gelp", "gonxfrang", "ramandjafari", "luf.a", "esenciakarmatica", "candelabcd", "gpoggio", "mandi.jpg", "hisami_tanaka", "mariaricabarra", "_3lmor4", "alexgamsujenkins", "nazem_088", "camilo_cami.lo", "maravishit", "_miki_kim_", "ivogonza_", "malena.peraltaa", "plantala_", "juan.dice", "lili4n__", "kubatattooer", "kenichi_hoshine", "neasdencontrolcentre", "macaboccia", "renidelrio", "jeroen_erosie", "blazejrusin", "santiagonicolasllorensbotto", "haunted_horfee", "agustinluppi", "johannesmundinger", "nachoeterno", "samfriedman", "jamesjeanart", "maty_haag", "1milliondiamonds", "felipepantone", "sainer_etam", "_nelio", "mr_aryz", "labuta_tattoo",'nickmakanna',
'si_si_oui_oui','originalpaperworks','beauwhiteart','sameoldsheep','ron_hotz','eriksommer.art','a.lamback','yeahgnar','bronko_impetueux','thomas_gillant','xaviceerre','playpaint_','willclaridge.art','publicdomainrev','kusssch','padrebio_','jkalionzes','hatano.reiya','imrichkovacs','originalpaperworks', 'dangwayneolsen', 'yuckysoba', 'la.romma', 'gxm.gem', 'jakub.glinsky','scarletmayerpayne','un_par_de_botas','insta_grems','agustinaskrt','fefaur','helline_du','b.elly','liardtrbdsgn','robszot','erikasabbat','diogo_dias_art','vanessanavarrete.art','rashe_insta','olegsson.art', 'barbora.myslikovjanova','annadegnbol', 'abstractintersect','caseyjexsmith','lindasemadeni','tim.peacock','julian.villalba.c','dva.ten','maselite','tuchyartistic','roybot'])
# let's go! :>
with smart_run(session):
    # settings
	session.set_relationship_bounds(enabled=True,
                                    potency_ratio=None,
                                    delimit_by_numbers=True,
                                    max_followers=4590,
                                    max_following=5555,
                                    min_followers=75,
                                    min_following=77)
	session.set_action_delays(enabled=True,
                           like=15,
                           comment=5,
                           follow=18.8,
                           unfollow=15,
                           story=10)
	session.set_quota_supervisor(enabled=True, sleep_after=["likes", "comments_d", "follows", "unfollows", "server_calls_h"], sleepyhead=True, stochastic_flow=True, notify_me=True,
                              peak_likes_hourly=80,
                              peak_likes_daily=10000,
                               peak_comments_hourly=21,
                               peak_comments_daily=182,
                                peak_follows_hourly=50,
                                peak_follows_daily=None,
                                 peak_unfollows_hourly=100,
                                 peak_unfollows_daily=402,
                                  peak_server_calls_hourly=400,
                                  peak_server_calls_daily=5000)
	session.set_user_interact(amount=1, randomize=True, percentage=100, media='Photo')
	##session.like_by_feed(amount=10, randomize=False, unfollow=False, interact=False)
	session.follow_user_followers(["oliviervrancken", "ritasalt", "scottbertram_art", "ingoalbrechthauser", "energygloop", "", "87mosa87", "or_kantor", "camiloortega.zv", "82eliote", "charleypeters", "saraandreasson", "moto583motohiro", "yosoyvalentino"], amount=3, randomize=True, interact=True)
	#session.like_by_locations(['216824405'], amount=20, skip_top_posts=True)#
	session.set_do_like(enabled=True, percentage=100)
	session.unfollow_users(amount=10, nonFollowers=True, style="RANDOM", unfollow_after=42 * 60 * 60, sleep_delay=300)
	session.like_by_tags(['drawing','artfair','artcollector','artdealer','artecontemporaneo','pintura','arteabstracto'], amount=1, use_smart_hashtags=False)
	session.set_user_interact(amount=2, randomize=True, percentage=100, media='Photo')
	session.follow_user_followers(["stephenellcock", "arieldavi.s", "fluff.faun", "sandroryry", "peter_fahr_junior", "skkinz"], amount=5, randomize=True, interact=True)
	session.like_by_tags(['contemporaryart','artcollecto','artdealer'], amount=5, use_smart_hashtags=False)
	session.unfollow_users(amount=10, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['arteabstracto','postvandalism'],amount=5, use_smart_hashtags=False)
	session.follow_user_followers(["violarenate", "krasivity", "hardgraverw", "xaviceerre", "nilsjendri"], amount=1, randomize=True, interact=True)
	session.unfollow_users(amount=10, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['arteabstracto''postvandalism','postanalog','postanalogpainting'],amount=5, use_smart_hashtags=False)
	session.follow_user_followers(["violarenate", "krasivity", "hardgraverw", "xaviceerre", "nilsjendri"], amount=1, randomize=True, interact=True)
	session.unfollow_users(amount=1, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['abstractpainting','abstractart','abstract'], amount=10, use_smart_hashtags=False)
	session.follow_user_followers(["paulgrodhues", "hensethename", "celestin_krier","nyiam_", "gommaargilliams",], amount=1, randomize=True, interact=True)
	session.unfollow_users(amount=1, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['painting', 'contemporarypainting','pintura'], amount=5, use_smart_hashtags=False)
	session.follow_user_followers(["quetzalau", "ourisazo", "flan_jm", "takujihanga", "ferrerartstudio"], amount=1, randomize=True, interact=True)
	session.unfollow_users(amount=1, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['contemporaryart','artcollecto','artdealer'],amount=5, use_smart_hashtags=False)
	session.follow_user_followers(["comfortablefields", "z_e_b_u", "lucampierre"], amount=5, randomize=True, interact=True)
	session.unfollow_users(amount=1, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['arteabstracto''postvandalism','postanalog','postanalogpainting'],amount=5, use_smart_hashtags=False)
	session.follow_user_followers(["jkovljevich", "thewalkingconurban", "louisedespont", "hirundoaves", "art_lobster", "roice183"], amount=1, randomize=True, interact=True)
	session.unfollow_users(amount=1, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['abstractpainting','abstractart','abstract'], amount=1, use_smart_hashtags=False)	
	session.follow_user_followers(["blo_dmv", "dangwayneolsen", "ram__han", "veranoal2020", "lenia_hauser", "padrebio_", "juan_zurita_benedicto"], amount=5, randomize=True, interact=True)
	session.unfollow_users(amount=1, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['painting', 'contemporarypainting','pintura'], amount=1, use_smart_hashtags=False)
	session.follow_user_followers(["maryameivazistudio", "joe_warrior_walker", "funskull", "publicdomainrev", "taylorothomas", "salt_lik", "volobevza"], amount=5, randomize=True, interact=True)
	session.unfollow_users(amount=1, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['contemporaryart','artcollecto','artdealer'],amount=5, use_smart_hashtags=False)
	session.follow_user_followers(["0111011cnztnz", "handpokejaus", "stephenellcock", "arieldavi.s", "fluff.faun", "sandroryry", "peter_fahr_junior", "skkinz"], amount=5, randomize=True, interact=True)
	session.unfollow_users(amount=1, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['arteabstracto''postvandalism','postanalog','postanalogpainting'],amount=5, use_smart_hashtags=False)
	session.follow_user_followers(["rebu_ceramics", "empache.lp", "jhnyo", "rosh333", "katefrizalis", "theo_lopez_artist", "ceramicism"], amount=1, randomize=True, interact=True)
	session.unfollow_users(amount=1, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)
	session.like_by_tags(['abstractpainting','abstractart','abstract'], amount=10, use_smart_hashtags=False)
	session.unfollow_users(amount=1, nonFollowers=True, style="FIFO", unfollow_after=12 * 60 * 60, sleep_delay=601)

	#session.join_pods(topic='entertainment', engagement_mode='light')
    #session.follow_by_tags(['art', 'painting'], amount=100, use_smart_hashtags=True)
