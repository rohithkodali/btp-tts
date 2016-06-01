#!/usr/bin/perl 
no warnings;
use utf8;
use Encode;
  
#$voiceHomeDir = "/home/kasthuri/festival.new/iitm_tam_aarthiSample";
my $combination;
my $voiceDir = '';
#print "-$ARGV[0]-\n";
#print "-$ARGV[0]-\n";
open FILE,  "<unit_size.sh" or die $!;
while (<FILE>) { 
	#print $_;
	$combination = "$_";
}
chomp($combination);
my $uvTagHex = "C77";
my $vTagHex = "C5C";
my $ivTagHex = "C5B";
my $temptag = "C64";

my $temp_Tag = 3172;

#my $uvTagStr = "_uv";
#my $vTagStr = "_v";
#my $ivTagStr = "_iv";

my $uvTagStr = "";
my $vTagStr = "";
my $ivTagStr = "";

my $BegTag = "_BEG";
my $MidTag = "_MID";
my $EndTag = "_END";
#my $tempstrTag = "_GEM";
my $tempstrTag = "";

$eachW = $ARGV[0];

#$eachW =~ s/.//;
#$eachW =~ s/-//;
#$eachW =~ s/‘//;
#$eachW =~ s/’//;
my %HashPhone=();
#print $eachW;
my $Phoneset =  "
సా_BEG
అం_BEG
నూర్_END
తిష్_BEG
సంక్_BEG
కుట్_BEG
వెళ్_MID
రాష్ట్_BEG
యజ్_BEG
వూ_BEG
వాం_MID
పోన్_BEG
ఫ్యాక్_BEG
రై_BEG
పి_MID
ప_BEG
టౌన్_BEG
కే_END
దన్_MID
ఖ_MID
రిం_MID
భౌ_BEG
ధృ_MID
తాన్_MID
గ్రం_BEG
టే_BEG
కాన్స్_BEG
ఇస్_BEG
క్రాస్_BEG
కోర్ట్_END
లిం_BEG
హిస్_MID
ఎల్_END
లౌ_MID
తే_MID
వి_BEG
జో_BEG
కొన్_BEG
డిచ్_MID
ధ_BEG
ఢీ_BEG
తం_BEG
శుక్_BEG
కిం_MID
ఓ_MID
డో_MID
వెచ్_BEG
పల్_END
నుం_BEG
పేట్_END
ద్రి_END
ధీ_MID
హు_END
జృం_MID
ధన్_MID
నెం_MID
పార్_BEG
దూ_END
అట్_BEG
షాఫ్ట్_BEG
ఛైర్_BEG
రిష్_MID
ణేష్_END
మధ్_BEG
మత్స్_BEG
సాం_BEG
జై_BEG
తిన్_MID
ఖి_MID
యంత్_BEG
డక్_END
రూ_BEG
త_BEG
పెం_BEG
కు_END
నోత్_MID
సూళ్_MID
ఐ_MID
డై_MID
షిప్_BEG
కోన్_BEG
కెట్_END
లాధ్_MID
స్వా_BEG
టు_BEG
హా_END
జ్ఞా_BEG
చౌర్_BEG
వర్_MID
షీ_MID
హం_MID
బుచ్_BEG
ది_END
యోగ్_BEG
లె_MID
పొ_BEG
తు_MID
నుద్_MID
టార్_MID
ఎన్_BEG
గడ్_BEG
పూర్_END
రి_BEG
కుప్_BEG
డ_BEG
నన్_MID
చిన్_BEG
టయ్_MID
తిస్_MID
మీట్ర్_MID
యొ_MID
కా_END
ప్రీ_BEG
కం_MID
భన్_END
టెక్_MID
భృ_BEG
రోడ్_BEG
చర్_MID
దుల్_END
మేష్_MID
టా_BEG
పన్_BEG
జెడ్_BEG
ఘాట్_BEG
పోస్_MID
లీం_END
క్రె_BEG
ఞప్_MID
కౌన్_BEG
టోత్_END
కేట్_END
పే_BEG
తా_MID
ధైర్_MID
జూ_BEG
పువ్_BEG
శి_END
ర్యా_BEG
సిక్_MID
శర్_MID
లొం_BEG
ముమ్_BEG
ణీ_END
థం_END
కార్_BEG
మెల్_MID
విడ్_BEG
యే_MID
యాక్_END
ధో_BEG
జిల్_END
మైన్_END
డూ_MID
తక్_BEG
నస్_MID
యిస్_MID
భీ_BEG
లిన్_END
రున్_MID
సర్_BEG
కొం_MID
ముళ్_MID
యాట్_BEG
త్ర_END
విద్_MID
దాస్_END
బో_MID
కాంత్_END
జ్వ_BEG
లీ_MID
మన్_END
యాత్_MID
నేర్_BEG
తిమ్_BEG
గొం_BEG
డింగ్_END
జి_BEG
బెం_BEG
అప్_BEG
స్వర్_MID
మల్_BEG
సింగ్_END
దిన్_MID
తిళ్_MID
డి_MID
వ్యూ_BEG
తెల్_BEG
గుట్_MID
మె_END
మష్_MID
షో_BEG
పోత్_MID
దెబ్_MID
కోళ్_BEG
క్రీ_BEG
లాల్_MID
నత్_END
పు_BEG
ఇయ్_BEG
డౌన్_MID
ముచ్_BEG
ఘ_BEG
కొట్_BEG
యు_MID
ధాన్_BEG
యన్_END
యిత్_MID
స్టిల్_BEG
గుప్_BEG
సజ్_BEG
యోధ్_MID
ణిక్_MID
ఆప్_BEG
డర్_END
ఎస్_MID
ఠం_MID
గొన్_MID
హిం_MID
కష్_BEG
శాశ్_BEG
చిస్_MID
త్రు_MID
పా_BEG
నాల్_BEG
క_BEG
యా_MID
దక్_BEG
ధూ_BEG
గల్_END
పస్_MID
ణాం_MID
పూడ్_BEG
నో_END
ల్యా_BEG
చె_END
మణ్_MID
షజ్_MID
యుం_MID
మీ_END
రం_END
యస్_END
జుల్_MID
లో_BEG
బూ_MID
కోట్_BEG
తె_BEG
వ్యక్_BEG
బస్_BEG
స్టీల్_BEG
ఏళ్_BEG
ద్ర_MID
జగ్_BEG
రైల్_BEG
ఒ_BEG
రన్_MID
పేర్_BEG
ఎట్_BEG
ఇం_BEG
శ్రో_BEG
నూల్_END
ధి_BEG
నై_END
ట్రై_BEG
చిట్_BEG
నట్_MID
బైక్_BEG
రిక్_BEG
ఎత్_MID
దిళ్_MID
లై_BEG
బి_MID
తృ_BEG
తాం_MID
బిడ్_MID
ఖా_BEG
గే_END
పట్_BEG
తవ్_END
దప్_MID
గంజ్_BEG
లభ్_MID
యుక్_MID
కన్_MID
బాగ్_BEG
టిం_MID
ఏ_BEG
డే_BEG
ష_END
పత్_MID
దాం_BEG
డిగ్_BEG
హె_MID
గండ్_MID
బ్రాహ్_BEG
జం_END
చీ_END
వేర్_BEG
దే_MID
జబ్_MID
షి_BEG
మైట్_END
సై_END
రాక్_MID
బత్_BEG
నయ్_MID
హార్_BEG
లెం_MID
తీ_BEG
దం_BEG
రుట్_MID
కుం_MID
ముప్_MID
స్కూల్_END
మిర్_BEG
ణో_MID
ఫా_END
గార్_MID
కె_MID
స్కూ_BEG
హెక్_BEG
గుం_BEG
జిస్_MID
మండ్_MID
టర్మ్_BEG
నూ_END
పాల్_BEG
అడ్_BEG
సిద్_BEG
డొచ్_MID
సూర్_BEG
దిట్_MID
సైక్_MID
ఘి_MID
శే_MID
గు_END
మార్_MID
టేజ్_END
రత్_END
కృ_MID
న్యా_BEG
ఉ_BEG
ళెం_MID
ఇద్_BEG
రూట్_MID
ద్రా_MID
రమ్_BEG
వల్_MID
బుజ్_BEG
హీ_MID
ని_END
షన్_END
వృధ్_MID
తర్_MID
తండ్_BEG
బొ_BEG
దు_MID
నున్_MID
టాల్_MID
వెం_BEG
సూ_END
ఎప్_BEG
నిమ్_BEG
ఒం_BEG
రావ్_END
ముఖ్_MID
కేంద్_MID
డ్రై_BEG
వాన్_MID
నప్_MID
పిల్_BEG
గా_END
శ్రద్_BEG
దర్_BEG
చేస్_MID
ఒత్_BEG
గన్_MID
కీ_MID
గం_MID
గొట్_MID
కమ్_BEG
నెల్_BEG
ఆ_BEG
మ_END
చెమ్_BEG
ఇంట్_BEG
లస్_MID
చెం_BEG
కళ్_MID
శాల్_MID
బే_BEG
దా_MID
గ్యాస్_BEG
జల్_BEG
వాస్_END
పయ్_MID
గ్రీన్_BEG
జెన్_MID
పుష్_BEG
సి_END
టో_END
శు_MID
కేం_BEG
ధం_END
కాల్_BEG
సన్_END
తీవ్_BEG
తగ్_BEG
జైన్_BEG
టిల్_MID
చంద్_BEG
ఏప్_BEG
లిప్_END
కౌం_MID
గస్_MID
మో_MID
ధర్_BEG
తజ్_MID
బ్లాక్_BEG
శం_MID
లీంగ్_END
ఖమ్_BEG
బాల్_BEG
అబ్_BEG
శా_MID
యక్_BEG
ళస్_MID
కట్_END
ణి_MID
షం_END
వీ_END
ప్లాన్_BEG
హో_BEG
న_END
రార్_MID
వస్_BEG
మై_MID
హన్_END
ప్యా_BEG
క్లీ_BEG
లిక్_MID
బు_BEG
పుణ్_BEG
కిష్_MID
షాన్_END
ఎఫ్_END
రెక్_MID
ళి_END
స్థి_MID
కో_BEG
డాల్_MID
బిల్_BEG
హై_BEG
టెం_END
చో_MID
థ_END
మెంట్_MID
నాప్_END
యుద్_BEG
బా_BEG
నిం_MID
టూ_END
నిక్_BEG
లక్ష్_BEG
కై_BEG
దగ్_BEG
తోత్_MID
పో_END
బర్_END
పిం_BEG
కక్_BEG
రీ_END
లం_END
ఘట్_BEG
మూ_MID
లట్_MID
ప్రత్_BEG
ఘు_BEG
ట్రక్స్_BEG
విళ్_MID
టి_END
ఛార్_MID
వెల్_BEG
ఫె_MID
క్ర_MID
మేడ్_END
మాం_MID
క్యా_BEG
రప్_MID
ఉం_BEG
పై_END
వాట్_MID
ళాప్_MID
టన్_MID
రాం_BEG
ట_END
ఎద్_MID
ఎం_MID
సిల్_MID
మి_MID
కున్_MID
షమ్_MID
దృ_BEG
ఫ్రే_BEG
పడ్_BEG
భు_END
లయ్_MID
టుం_MID
బ్యా_BEG
కాట్_END
భిన్_BEG
కూ_BEG
దీం_BEG
జెట్_MID
ఖో_END
పెల్_MID
హ_MID
డ్యాం_BEG
భర్_MID
హాన్_END
కాం_BEG
నంద్_END
జీ_END
విచ్_BEG
నే_MID
హి_BEG
చూ_MID
జ_END
లెత్_MID
బద్_BEG
హాల్_BEG
లైం_MID
దీర్_BEG
నం_BEG
దీ_BEG
జ్యో_BEG
మిల్_BEG
గయ్_MID
డెం_MID
భా_END
గె_MID
కోస్ట్_BEG
గాల్_MID
నీప్_MID
భం_MID
ఫీ_MID
ధీర్_END
జెక్ట్_END
ట్రెం_BEG
ఇంద్_BEG
కి_BEG
మిష్_MID
ఇన్స్_BEG
శ_MID
బిం_BEG
ఖాస్_MID
స్పం_BEG
చి_MID
ఛీఫ్_BEG
షిత్_END
టర్వ్_MID
ప్లాట్_BEG
సే_MID
ఫిక్_END
మర్_MID
పొం_BEG
సేం_MID
ఫిట్స్_BEG
టైల్స్_BEG
లేక్_MID
మాల్_MID
డెల్_END
టైల్_MID
శీ_BEG
సం_BEG
గృ_MID
భద్_BEG
ఇన్_BEG
తొ_END
ళ_MID
దుద్_MID
పి_END
నధ్_BEG
ఫోర్స్_MID
తల్_MID
మిక్స్_END
మొ_BEG
పుట్_MID
ను_MID
సుల్_MID
రవ్_MID
దన్_END
ఖ_END
నిర్_BEG
సిస్_BEG
కుమ్_BEG
మీష్_MID
సక్_BEG
టళ్_MID
ప్రాం_MID
గప్_MID
నివ్_MID
గీ_MID
కర్_BEG
చాం_END
తోం_MID
రింగ్_END
వై_MID
తే_END
యర్_MID
ఇండ్_BEG
ర_MID
మగ్_BEG
ప్లాం_BEG
స్తున్_MID
గౌడ్_BEG
శిక్_MID
మే_BEG
నా_MID
ఓ_END
ఘాన్_MID
డో_END
నార్_MID
నష్_BEG
సు_MID
ధీ_END
టోల్_BEG
కిక్_BEG
ఆంధ్_BEG
ట్రస్_BEG
భిస్_MID
థల్_MID
ఫో_BEG
బుళ్_MID
స్థా_BEG
ధన్_END
నెక్_MID
లొచ్_MID
కిచ్_MID
శాం_MID
దేవ్_END
ఖి_END
రో_MID
భ_MID
చొ_BEG
యాన్_MID
ఖర్_BEG
జక్_MID
ఐ_END
డై_END
అమ్_BEG
సా_MID
స్టె_BEG
మాస్_BEG
ఫై_BEG
సంక్_MID
థి_MID
గేష్_END
వర్_END
హం_END
బిచ్_MID
రాష్ట్_MID
లె_END
వూ_MID
లోక్_BEG
తు_END
రాల్_MID
రై_MID
యాస్_END
ప_MID
రోఖ్_MID
చే_BEG
లిగ్_MID
టయ్_END
ము_BEG
ఇళ్_BEG
ఫల్_END
కం_END
వార్_BEG
టే_MID
చర్_END
గో_BEG
స్మగ్_BEG
మేష్_END
ళు_MID
డిక్_MID
దళ్_END
షిక్_BEG
లిం_MID
టం_BEG
వి_MID
కొన్_MID
తా_END
మర్స్_END
స్వఛ్_BEG
ఉస్_BEG
ఘిస్_MID
ధ_MID
తం_MID
సిక్_END
దాల్_BEG
రాంధ్_MID
సేన్_BEG
మా_BEG
యే_END
సౌ_BEG
తోడ్_BEG
డూ_END
నుం_MID
ద్వి_BEG
క్యాంప్_BEG
మాత్_BEG
గిం_MID
ళా_MID
శెట్_BEG
పార్_MID
బల్_END
మధ్_MID
సాం_MID
త్యా_BEG
లీ_END
వద్_BEG
స_BEG
యంత్_MID
రూ_MID
నె_BEG
త_MID
ళిం_MID
చు_BEG
ఇట్_BEG
పెక్_MID
టమ్స్_END
దిన్_END
తున్_MID
డి_END
కోన్_MID
స్వా_MID
శ్వ_MID
రాష్ట్త్_BEG
టు_MID
విం_BEG
ఫి_BEG
బుచ్_MID
బై_END
టప్_MID
అహ్_BEG
పొ_MID
స్వ_BEG
వ_BEG
స్పె_BEG
ఉత్_BEG
రాస్_BEG
మిత్_BEG
గడ్_MID
దిష్_MID
లబ్_BEG
డౌన్_END
రి_MID
ఫ్యాక్స్_BEG
డ_MID
చా_BEG
యు_END
సె_BEG
స్విమ్స్_BEG
టీర్_MID
ప్రశ్_BEG
భుత్_MID
చిం_BEG
రోడ్_MID
హర్_BEG
టా_MID
డయ్_MID
గూ_BEG
పన్_MID
భల్_MID
వొ_BEG
నొప్_MID
ఎస్_END
దీన్_END
ఠం_END
స్పష్_BEG
పే_MID
విజ్_BEG
జర్_MID
ల_BEG
రేష్_END
జూ_MID
ఞ_MID
పం_BEG
నీ_BEG
గొల్_BEG
కార్_MID
యా_END
పస్_END
తేల్_BEG
ప్రగ్_MID
ఊత్_BEG
భీ_MID
యం_MID
సర్_MID
వాగ్_BEG
రెల్_END
గి_BEG
కీర్_BEG
బార్_END
వే_BEG
రాత్_BEG
య_BEG
స్పీ_BEG
గొం_MID
జి_MID
ద్ర_END
త్రం_MID
ఛ_MID
మల్_MID
ఏస్_END
శస్త్_BEG
మిక్_MID
రన్_END
వ్యూ_MID
సీ_BEG
తుమ్_BEG
వృద్_BEG
షో_MID
ఇప్_BEG
లుష్_MID
వశ్_MID
స్టాం_BEG
ముక్_BEG
దున్_MID
దొడ్_MID
తుళ్_MID
టోక్_BEG
బి_END
షేక్_BEG
టర్_BEG
తాం_END
పు_MID
బ_BEG
యణ్_END
నిల్_BEG
ఎమ్_BEG
సాప్ట్_BEG
ఘ_MID
కన్_END
ప్రో_BEG
బంగ్_BEG
పత్_END
చూస్_BEG
ధాన్_MID
ఒన్_BEG
నిష్_MID
ఛం_MID
సజ్_MID
ధుల్_MID
కల్_BEG
ణయ్_MID
థా_BEG
ఆప్_MID
కాంక్_BEG
దే_END
చెల్_BEG
యల్_MID
లేశ్_MID
యుత్_MID
లెం_END
వు_BEG
కష్_MID
రే_BEG
పా_MID
పోస్ట్_BEG
పాధ్_MID
నాల్_MID
డైట్_BEG
స్త్రీ_BEG
కె_END
క_MID
కోం_BEG
ప్రై_BEG
విధ్_BEG
దక్_MID
భో_BEG
కోచ్_BEG
బ్రహ్_BEG
వం_BEG
డెప్_BEG
సెట్_MID
కూర్_BEG
భార్_BEG
హెచ్_END
లో_MID
కోట్_MID
నక్_BEG
షోత్_MID
తె_MID
బస్_MID
ల్లో_BEG
వా_BEG
జొ_BEG
ఖు_MID
యాప్_MID
నోద్_END
ద_BEG
మార్_END
అర్_BEG
క్యాం_BEG
స్వీ_BEG
భై_BEG
ధి_MID
వల్_END
కొచ్_MID
పార్ట్_END
జూన్_BEG
తెస్_BEG
తృత్_MID
బ్యాం_BEG
పచ్_BEG
పెద్_BEG
దు_END
నః_END
లై_MID
లన్_MID
పౌ_BEG
మెట్_BEG
తృ_MID
సొత్_BEG
ప్ర_BEG
జే_BEG
ఖా_MID
ధ్వం_BEG
స్పామ్_END
వాన్_END
చుట్_BEG
పట్_MID
రు_BEG
ఇవ్_BEG
ధిస్_MID
గన్_END
కీ_END
గం_END
మెత్_MID
గోళ్_MID
గ్రీ_MID
ఏ_MID
యెట్_END
వాల్_BEG
డే_MID
చల్_END
జిత్_END
బట్_BEG
దవ్_END
లుం_MID
టీ_BEG
సెంట్_BEG
గుర్_BEG
లస్_END
మైత్_BEG
డిం_MID
షి_MID
దా_END
నాం_BEG
హార్_MID
దం_MID
తీ_MID
శు_END
రా_BEG
క్వై_MID
అజ్_BEG
ఎక్_BEG
రీక్_MID
టిల్_END
ప్రి_BEG
గుం_MID
ధ్రు_BEG
కాష్_END
భూ_BEG
మో_END
లాట్_BEG
పాల్_MID
సిద్_MID
యేం_MID
ప్రొద్_BEG
రెస్_MID
శం_END
వన్_BEG
స్వామ్_MID
పార్క్_BEG
లూ_MID
పె_BEG
జు_BEG
శా_END
సెప్_MID
యార్_BEG
విష్_MID
మర్థ్_MID
బుగ్_BEG
ణి_END
షణ్_END
భత్_MID
డు_MID
వుం_BEG
రమ్_MID
దీక్_BEG
రార్_END
శ్మ_BEG
మై_END
లత్_END
సోం_BEG
తిం_BEG
వెం_MID
పోర్_BEG
ఉద్_BEG
ఘుం_MID
లి_MID
షల్_MID
ధ్వ_BEG
వీన్_END
మూర్_BEG
మైక్_MID
జా_BEG
పిల్_MID
బ్రౌన్_BEG
డబ్_BEG
దర్_MID
తొమ్_BEG
డ్యాన్_BEG
శ్రద్_MID
రేం_MID
చ_BEG
టీల్_MID
ప్రస్_BEG
హల్_BEG
ఆ_MID
డా_MID
మొక్_BEG
బుధ్_BEG
పుల్_BEG
మెంట్_END
నర్_BEG
మక్_MID
సాంస్_BEG
రెత్_MID
చెం_MID
శీల్_END
టేశ్_MID
బే_MID
జల్_MID
తీర్_BEG
తో_BEG
మొచ్_MID
కొర్_BEG
ఫేజ్_BEG
క్రి_BEG
భైం_BEG
పీ_BEG
బం_BEG
కేం_MID
రక్_BEG
సభ్_BEG
వత్స్_MID
కాల్_MID
హోం_BEG
ఎక్స్_BEG
గళ్_MID
జిస్ట్_MID
గ_BEG
బయ్_MID
చంద్_MID
లైన్_BEG
యహ్_MID
సల్_MID
వ్యా_BEG
ట్ర్_BEG
బృం_BEG
ధర్_MID
నిత్_BEG
ల్యాబ్_BEG
అధ్_BEG
టుల్_MID
నింగ్_END
సెం_BEG
వున్_MID
దోన్_MID
కేశ్_BEG
బాల్_MID
యక్_MID
చెక్_BEG
శుభ్_BEG
కోర్_BEG
ఇబ్_BEG
శాన్_MID
వస్_MID
ముగ్_BEG
దౌ_MID
తాంధ్_MID
ఎం_END
సిల్_END
మి_END
లొ_BEG
బు_MID
రహ్_MID
యిడ్_MID
ఎర్_BEG
యోత్_MID
తొం_BEG
దండ్_MID
కో_MID
ఆధ్_BEG
జెట్_END
బోర్_BEG
ఒప్_BEG
గ్రూ_BEG
హ_END
అండ్_BEG
టేల్_END
కాంగ్_BEG
నే_END
పర్_BEG
షు_BEG
కృష్_BEG
లే_BEG
బా_MID
తూ_BEG
డెం_END
స్టాండ్_BEG
లక్_BEG
లక్ష్_MID
యాం_MID
భం_END
ఫీ_END
కాస్_BEG
కై_MID
జొన్_MID
యో_BEG
సంస్_BEG
ఎ_BEG
డె_BEG
శ_END
టిస్_MID
పిం_MID
ఏర్_BEG
కక్_MID
సస్_BEG
శ్రే_BEG
వత్_MID
చి_END
నగ్_BEG
దె_MID
జేట్_END
ఢిల్_BEG
షా_BEG
ఘు_MID
సే_END
మర్_END
ప్రెస్_END
తి_BEG
చట్_BEG
డాన్_MID
అల్_BEG
కేష్_END
రీఫ్_MID
డుల్_MID
చోట్_BEG
టెంట్_END
వో_END
దిర్_MID
శిస్_MID
ఋ_BEG
ళ_END
గ్ర_MID
పెన్_BEG
రాం_MID
ను_END
రిగ్_MID
క్లో_BEG
టిక్_END
దుర్_BEG
ఘా_MID
డన్_MID
పడ్_MID
లు_BEG
ఇష్_BEG
సాన్_MID
గిల్_MID
లాం_BEG
హిష్_MID
రాక్ట్_END
ఆంగ్_BEG
విక్_BEG
జిద్_END
కూ_MID
వై_END
బడ్_BEG
యర్_END
క్విం_BEG
ఈ_BEG
డీ_BEG
ర_END
సత్_BEG
డుం_MID
హి_MID
నా_END
వర్క్_BEG
ట్రా_BEG
బద్_MID
హాల్_MID
నార్_END
నం_MID
దీ_MID
క్లబ్_BEG
టెన్_MID
స్టేట్_BEG
సు_END
గాం_BEG
మిల్_MID
లా_BEG
ఎగ్_BEG
రిశ్_MID
మద్_BEG
చొప్_BEG
ప్రెమ్_BEG
కి_MID
యూ_BEG
రో_END
అ_BEG
భ_END
నెట్_BEG
శ్రా_BEG
యాన్_END
బె_BEG
డిస్_MID
మిం_BEG
పొం_MID
టొ_END
నెత్_MID
సున్_BEG
సా_END
హత్_BEG
గేశ్_MID
వయ్_MID
జట్_BEG
జెక్_MID
శీ_MID
సం_MID
థి_END
వృత్_MID
భద్_MID
ణు_MID
క్వా_BEG
రర్_MID
చేర్_BEG
ఏం_BEG
రై_END
ణాన్_MID
ప_END
టమ్_MID
టౌన్_END
మొ_MID
చోప్_BEG
వైం_MID
హెశ్_MID
వీంద్_MID
ఉన్_BEG
మిన్_BEG
నిర్_MID
సిస్_MID
సక్_MID
స్టెప్_BEG
టే_END
పధ్_BEG
న్యూస్_BEG
పెళ్_BEG
నాద్_BEG
త్రి_BEG
ళు_END
సేల్స్_BEG
లిం_END
రెడ్_BEG
జాగ్_BEG
కర్_MID
తాల్_MID
టేం_MID
మోర్_MID
ణా_MID
యూల్_END
డళ్_MID
వి_END
నల్_BEG
మగ్_MID
శయ్_MID
ఖుస్_MID
ధ_END
తం_END
టేస్_MID
మే_MID
గర్_BEG
దో_BEG
హాస్_BEG
చైర్_BEG
యిష్_MID
మం_BEG
బీ_BEG
రిల్_END
సయ్_BEG
మిస్_BEG
మంత్_BEG
ళా_END
డ్రా_BEG
స్థా_MID
ణస్_MID
కొ_BEG
నీర్_MID
ళం_MID
హక్_MID
సాం_END
జై_END
రూ_END
హే_BEG
త_END
వైట్_END
దై_BEG
ఠి_MID
భీమ్_BEG
ప్రార్_BEG
శో_BEG
పెట్_BEG
ఢెల్_MID
టు_END
ఘర్_BEG
కోల్_BEG
తెశ్_MID
కే_BEG
ణిస్_MID
లోక్_MID
ఫోన్_BEG
రి_END
చే_MID
డ_END
తస్_MID
ము_MID
ఎల్_BEG
చం_BEG
సీట్_BEG
సంప్_BEG
బియ్_BEG
శై_BEG
గో_MID
టా_END
ణోగ్_MID
గాత్_MID
నాధ్_END
టం_MID
ప్రోత్_BEG
పే_END
పల్_BEG
జర్_END
జూ_END
పేట్_BEG
అక్_BEG
యున్_MID
హు_BEG
ఞ_END
జాఢ్_BEG
మాట్_BEG
దాల్_MID
మా_MID
విడ్_END
దూ_BEG
డిప్_BEG
ముస్_BEG
యం_END
మాత్_MID
వడ్_BEG
సర్_END
శిం_BEG
గై_MID
శెట్_MID
తట్_BEG
కు_BEG
ఆహ్_BEG
ఇచ్_BEG
రుల్_MID
స_MID
వద్_MID
భిక్_BEG
ఎంట్_BEG
జి_END
వెయ్_BEG
నె_MID
హా_BEG
చు_MID
రధ్_MID
మల్_END
యామ్_MID
గగ్_BEG
ఆం_BEG
ది_BEG
సంఖ్_BEG
మిక్_END
వేక్_MID
ఆక్_BEG
పూర్_BEG
విం_MID
ఉట్_BEG
సైన్_MID
ఫి_MID
తాత్_BEG
కా_BEG
వ_MID
రీం_MID
పు_END
దాన్_BEG
రిఙ్_MID
రాస్_MID
మిత్_MID
షిం_BEG
మౌ_BEG
కాజ్_END
చా_MID
ఫిర్_BEG
శార్ట్_BEG
సె_MID
ధాన్_END
ముత్_BEG
చిం_MID
హర్_MID
నెన్స్_END
విగ్_BEG
భిప్_MID
శి_BEG
గూ_MID
డ్రాఫ్_BEG
గాప్_BEG
డేళ్_MID
టిద్_MID
నమ్_MID
యల్_END
రొగ్_MID
వ్యాప్_BEG
సద్_BEG
యుత్_END
దృష్_BEG
జిల్_BEG
జిం_BEG
ల_MID
పా_END
నాల్_END
నీ_MID
పం_MID
క_END
మీక్_MID
నేం_MID
రిస్_MID
మన్_BEG
సిం_BEG
గి_MID
కీర్_MID
ఫ్యాక్ట్_BEG
బేత్_MID
లో_END
కోట్_END
వే_MID
తె_END
సింగ్_BEG
రాత్_MID
య_MID
విశ్_BEG
చౌ_BEG
రైల్_END
లాన్_MID
మె_BEG
తప్_BEG
శ్యాం_BEG
ముం_BEG
సుప్_BEG
జడ్_BEG
గెట్_BEG
సీ_MID
సిఫ్_END
ధి_END
నత్_BEG
వృద్_MID
తయ్_MID
మెం_MID
మాండ్_MID
థు_MID
యాహ్_MID
రిక్_END
వ్యాఖ్_BEG
లన్_END
లై_END
టర్_MID
ఖా_END
రొ_MID
బ_MID
రెం_BEG
ఉప్_BEG
సాద్_END
సంద్_MID
కుర్_MID
మృ_BEG
ఠా_BEG
డే_END
చూస్_MID
సార్_BEG
రిత్_MID
మియ్_MID
హైస్_BEG
కల్_MID
థా_MID
కాంక్_MID
లెన్స్_END
బొత్_BEG
షి_END
వు_MID
తీ_END
దం_END
రెన్_MID
రే_MID
గల్_BEG
నో_BEG
మిర్_END
భేక్_BEG
చె_BEG
ఆర్_BEG
మీ_BEG
రం_BEG
కోం_MID
గష్_MID
టె_MID
పెంట్_END
గొ_BEG
పాల్_END
ళీ_MID
వం_MID
కూర్_MID
రెస్_END
ణెమ్_MID
నక్_MID
మేట్_BEG
చిక్_BEG
లూ_END
అఫ్_BEG
లిస్_MID
వా_MID
రీత్_MID
మళ్_BEG
సొం_BEG
రాప్_BEG
నేశ్_MID
ద_MID
కొక్_MID
పక్_BEG
మస్_MID
సో_BEG
హిర్_END
డు_END
ద్వా_BEG
గిద్_BEG
భై_MID
స్వీ_MID
మీర్_END
గే_BEG
స్లిప్_BEG
తవ్_BEG
బ్యాం_MID
పెద్_MID
మెట్_MID
ఘుం_END
లి_END
షల్_END
ప్ర_MID
జే_MID
రు_MID
నుల్_MID
వస్త్_BEG
ణ_MID
దర్_END
జం_BEG
చీ_BEG
వాల్_MID
సై_BEG
బ్ర_BEG
ఆఫ్_BEG
లీస్_MID
డా_END
బట్_MID
ఉవ్_BEG
టీ_MID
డం_MID
స్కూల్_BEG
కస్_BEG
దేన్_BEG
చెం_END
ఫా_BEG
టేశ్_END
ఫక్_BEG
చెస్_BEG
జల్_END
నాం_MID
అగ్_BEG
మట్_BEG
స్పోర్ట్స్_BEG
రా_MID
మొత్_BEG
నూ_BEG
ఠ_MID
ఫ్లె_BEG
ణిం_MID
నాస్_MID
మత్_MID
పాం_BEG
లింగ్_END
లెన్_MID
మాద్_MID
ప్రి_MID
కూబ్_END
భూ_MID
గు_BEG
ఇజ్_BEG
రత్_BEG
వన్_MID
ఓట్_BEG
రైళ్_BEG
పె_MID
జు_MID
టాన్_MID
యక్_END
యార్_MID
సిబ్_BEG
ని_BEG
పిన్_BEG
ఆగ్_BEG
సూ_BEG
వుం_MID
రావ్_BEG
దీక్_MID
భి_MID
కిల్_END
వీణ్_END
తృప్_MID
తిం_MID
గా_BEG
యత్_MID
డ్రిల్_BEG
బు_END
పోర్_MID
ఉద్_MID
సాధ్_BEG
వె_BEG
లమ్_MID
యిడ్_END
రౌ_BEG
నల్స్_END
మూర్_MID
డొర్_END
మ_BEG
జా_MID
దిం_BEG
పథ్_MID
తొమ్_MID
కో_END
చ_MID
ఔట్_BEG
వాస్_BEG
సి_BEG
టో_BEG
పుల్_MID
టింగ్_END
వేంద్_MID
నర్_MID
లేం_MID
సన్_BEG
హెం_BEG
ఖాన్_END
దార్_END
తీర్_MID
తో_MID
రివ్_BEG
నిక్_END
పీ_MID
బం_MID
సభ్_MID
ఫ_BEG
రక్_MID
హోం_MID
భాధ్_MID
జెం_MID
థిం_MID
కై_END
గ_MID
ళాక్_MID
ప్రొ_BEG
వేష్_END
టిస్_END
సుం_BEG
వ్యా_MID
గేం_MID
టై_BEG
డోర్_END
చార్_MID
షే_MID
దె_END
మయ్_MID
కట్_BEG
రేట్_MID
వమ్_BEG
తై_MID
విస్_BEG
వీ_BEG
రె_BEG
ధ్య_MID
న_BEG
సుబ్_BEG
రీఫ్_END
శుభ్_MID
కోర్_MID
మైం_MID
ధు_MID
గ్రస్_MID
ఫర్_BEG
టాళ్_MID
వేం_BEG
రాం_END
ఎఫ్_BEG
జన్_MID
ఫ్యా_BEG
టల్_MID
గ్రౌం_BEG
లొ_MID
ఘం_MID
ఖీ_MID
గిల్_END
కుల్_MID
షస్_MID
బ్రీఫ్_BEG
టెం_BEG
స్థ_BEG
తొం_MID
చిర్_MID
పిస్_MID
చెయ్_BEG
పాట్_BEG
కూ_END
సాల్_BEG
రిద్_MID
దృష్ట్_BEG
హస్_BEG
టోం_MID
భే_BEG
ధా_MID
పర్_MID
టూ_BEG
దొం_BEG
దొమ్_MID
పుస్_BEG
పాత్_MID
రాజ్_BEG
బాండ్_BEG
రుద్_BEG
షు_MID
నం_END
దీ_END
వచ్_BEG
బాన్_MID
కృష్_MID
విత్_BEG
లే_MID
జస్_MID
జివ్_END
పో_BEG
తూ_MID
బుల్_MID
లక్_MID
రీ_BEG
కి_END
యో_MID
సంస్_MID
వెన్_BEG
ఎ_MID
డె_MID
పెండ్_END
యింట్_MID
కూల్_MID
హెడ్_BEG
టి_BEG
జార్_END
మేడ్_BEG
ఢిల్_MID
అభ్_BEG
షా_MID
పై_BEG
క్రిష్_BEG
తి_MID
షత్_MID
సం_END
చిల్డ్_BEG
స్ట_BEG
ట_BEG
చోట్_MID
లెక్ట్_MID
గైడ్_BEG
గిన్_BEG
హైద్_BEG
రర్_END
ధౌ_BEG
జీవ్_END
ప్రా_BEG
లావ్_MID
చార్జ్_END
భు_BEG
శ్ర_BEG
ఇల్_BEG
లెక్_BEG
కిస్_MID
దుర్_MID
ఖో_BEG
మేశ్_END
లు_MID
లాం_MID
నంద్_BEG
జీ_BEG
షిఫ్ట్_BEG
రుగ్_MID
కర్_END
జ_BEG
శాయ్_END
ణా_END
గాన్_MID
భిం_MID
స్వచ్_BEG
ఉష్_BEG
డీ_MID
ణం_MID
భా_BEG
గౌడ్_END
వ్ర_MID
మే_END
పశ్_BEG
లైట్_MID
లిద్_MID
చక్_BEG
నేత్_MID
ఖై_BEG
లా_MID
పూ_BEG
జేక్_MID
వేస్_BEG
నీర్_END
ళం_END
మాన్_MID
శృం_BEG
యూ_MID
అ_MID
డిళ్_MID
నెట్_MID
రద్_BEG
కిత్_MID
భాస్_BEG
హేశ్_MID
ఖేష్_END
ఖర్_END
లైన్స్_BEG
వెళ్_BEG
తన్_MID
మిం_MID
తొ_BEG
బిక్_END
హత్_MID
యాల్_MID
నిద్_BEG
పి_BEG
కెన్_MID
బిట్_BEG
ఖ_BEG
డుస్_MID
రిం_BEG
దిశ్_MID
యి_MID
షయ్_MID
ధృ_BEG
తాన్_BEG
సెల్_BEG
తుం_MID
వైస్_BEG
చే_END
ము_END
ఉన్_MID
ఇంగ్_BEG
డేన్_END
ద్వాక్_BEG
లర్_MID
రింగ్_BEG
బ్రా_BEG
తే_BEG
ఞా_MID
టెస్ట్_BEG
జప్_BEG
వార్_END
పధ్_MID
దుం_BEG
గో_END
త్రి_MID
డేల్_BEG
గిస్_MID
కిం_BEG
మున్_BEG
టం_END
జాగ్_MID
రెడ్_MID
కాప్_BEG
హాం_END
ఓ_BEG
జయ్_MID
డో_BEG
రేశ్_END
దెం_MID
ఫెస్_BEG
ధీ_BEG
గర్_MID
డేం_MID
సేన్_END
దో_MID
కొల్_MID
లుద్_MID
మా_END
డాక్_BEG
ధన్_BEG
గాళ్_MID
నెం_BEG
మం_MID
బీ_MID
సెంబ్_MID
గేంద్_MID
మిస్_MID
మంత్_MID
వెత్_MID
అత్_BEG
కొ_MID
మబ్_BEG
ఛాం_BEG
ఐ_BEG
డై_BEG
స_END
చాల్_MID
హే_MID
డీచ్_BEG
నె_END
ట్రె_BEG
చు_END
సాక్_BEG
గిట్_BEG
రాన్_MID
మాళ్_MID
వర్_BEG
టేట్_END
దై_MID
షీ_BEG
హం_BEG
లె_BEG
తమ్_BEG
వాజ్_END
తు_BEG
శో_MID
పెట్_MID
గిత్_MID
తుల్_MID
కే_MID
న్యూ_BEG
గ్రా_BEG
షాప్_BEG
వ_END
రీం_END
గద్_BEG
కం_BEG
రాస్_END
గుత్_BEG
టెక్_BEG
కెళ్_MID
చర్_BEG
వేత్_MID
ఆత్_BEG
రొం_BEG
హుస్_BEG
ట్రాన్స్_BEG
పోస్_BEG
ఉమ్_BEG
చం_MID
ఘీ_MID
ఫైట్_END
తాళ్_BEG
ణమ్_MID
టైం_BEG
తౌం_MID
తా_BEG
హర్_END
యేష్_END
దస్_MID
సిక్_BEG
రిన్_MID
శర్_BEG
పొత్_BEG
ఊ_BEG
పల్_MID
ట్యాక్స్_BEG
ల_END
పేట్_MID
ద్రి_MID
బన్_END
శవ్_MID
బ్ల్_BEG
హు_MID
కొం_BEG
నీ_END
పం_END
వజ్_BEG
విద్_BEG
బో_BEG
దూ_MID
తచ్_BEG
సర్క్_BEG
బంద్_BEG
ఇక్_BEG
లీ_BEG
మౌంట్_BEG
యాత్_BEG
శిం_MID
డక్_MID
దేశ్_END
గి_END
ధళ్_BEG
ఫార్_MID
స్వర్_BEG
కు_MID
వే_END
ఈస్ట్_BEG
ట్రక్_BEG
ఇ_BEG
రాత్_END
డి_BEG
య_END
కెట్_MID
అయ్_BEG
శ్రీ_BEG
హా_MID
వ్య_BEG
గుట్_BEG
ధ్యే_BEG
పోత్_BEG
హెన్_MID
రామ్_BEG
బై_BEG
సంఖ్_MID
ది_MID
షిర్_END
ట్యాం_BEG
సీ_END
లాల్_BEG
ఆక్_MID
దత్_MID
మాండ్_END
పూర్_MID
రాళ్_MID
మిట్_MID
రల్_END
రోగ్_MID
కా_MID
టర్_END
యు_BEG
రొ_END
దాన్_MID
బ_END
ధిష్_MID
షిం_MID
ముట్_BEG
నిల్_END
మౌ_MID
దుల్_MID
శీద్_END
ఘో_BEG
కొత్_BEG
ప్లాంట్_BEG
ఎస్_BEG
దీన్_BEG
రీస్_MID
హిం_BEG
యూళ్_MID
షేత్_MID
కల్_END
శి_MID
యిడ్స్_END
శోక్_END
ణీ_MID
థం_MID
వూర్_MID
వు_END
మృత్_BEG
దృష్_MID
జిం_MID
యా_BEG
బాద్_END
రే_END
కాంట్_BEG
హౌ_BEG
త్ర_MID
బార్_BEG
బ్యాక్_BEG
రెస్ట్_END
మొన్_BEG
బూ_BEG
టె_END
మన్_MID
వస్త్ర్_BEG
సిం_MID
నీల్_END
త్రా_BEG
ళీ_END
వం_END
కిడ్_BEG
ట్రాక్_BEG
నిమ్స్_BEG
కౌ_BEG
తెన్_MID
పేం_MID
వా_END
లిస్_END
రుస్_MID
రన్_BEG
గేళ్_MID
త్వా_MID
విశ్_MID
నేశ్_END
ద_END
మె_MID
తప్_MID
ముం_MID
దొ_BEG
హద్_MID
నిన్_BEG
ఎత్_BEG
బి_BEG
భై_END
చిత్_BEG
నత్_MID
తాం_BEG
క్యూ_BEG
దిస్_MID
కన్_BEG
పత్_BEG
డెక్_MID
యన్_MID
చెన్_BEG
దయ్_MID
రెం_MID
నాణ్_BEG
రు_END
హె_BEG
గండ్_BEG
ణ_END
లల్_MID
దుస్_BEG
శాబ్_MID
దే_BEG
ఠా_MID
జబ్_BEG
డెంట్_END
వాల్_END
డర్_MID
నాన్_MID
లీస్_END
సార్_MID
శొ_BEG
కుం_BEG
ముప్_BEG
టీ_END
డం_END
మాఖ్_MID
రాంత్_END
దైం_MID
కె_BEG
నాం_END
రుత్_MID
సబ్_BEG
సెక్_MID
గల్_MID
రోల్_END
దిక్_END
తుక్_MID
నో_MID
లున్_MID
రా_END
హృ_BEG
చె_MID
మోస్_BEG
ఠ_END
క్రైం_BEG
ఆర్_MID
రం_MID
మీ_MID
గొస్_MID
యస్_MID
హెచ్_BEG
బ్యాంక్_BEG
తిప్_BEG
అద్_BEG
శే_BEG
లిళ్_MID
గొ_MID
ళల్_MID
ఢెప్_BEG
మార్_BEG
గౌస్_BEG
వన్_END
కృ_BEG
విల్_END
బుల్స్_END
వైద్_BEG
జు_END
గిడ్_BEG
వల్_BEG
టాన్_END
నై_MID
హీ_BEG
తర్_BEG
చుక్_BEG
మేం_BEG
పక్_MID
దు_BEG
సో_MID
లుస్_MID
ముఖ్_BEG
కేంద్_BEG
భి_END
గే_MID
యత్_END
చేస్_BEG
రస్_MID
గన్_BEG
కీ_BEG
గం_BEG
సంధ్_BEG
ష_MID
చల్_BEG
జా_END
వస్త్_MID
హాద్_MID
త్వ_BEG
నిస్_MID
చీ_MID
చ_END
భాగ్_MID
కళ్_BEG
జాక్_END
దా_BEG
సై_MID
బ్ర_MID
సిగ్_BEG
నర్_END
శు_BEG
లేం_END
యిర్_END
కస్_MID
బాధ్_BEG
ఫా_MID
టెన్త్_BEG
తెచ్_BEG
మొట్_BEG
చెస్_MID
తో_END
లాక్_BEG
నాళ్_MID
కౌం_BEG
పీ_END
బం_END
డెడ్_END
విన్_BEG
మో_BEG
నూ_MID
స్నా_BEG
భక్_BEG
గ_END
టిష్_MID
నీళ్_BEG
శం_BEG
లైన్_END
రట్_BEG
షెడ్_BEG
జెంట్_MID
స్వల్_BEG
శా_BEG
గు_MID
రత్_MID
సిధ్_BEG
రేట్_END
షణ్_BEG
కేశ్_END
మహ్_BEG
ఒక్_BEG
మై_BEG
ని_MID
షన్_MID
వుల్_MID
ఆగ్_MID
చెట్_BEG
సూ_MID
స్టాక్_BEG
ధు_END
కిష్_BEG
డేడ్_END
కత్_MID
జన్_END
మోత్_MID
స్థి_BEG
లిచ్_MID
గా_MID
వ్యర్_BEG
వైశ్_MID
టల్_END
మ్యాన్_BEG
పున్_BEG
లొ_END
సాధ్_MID
ఘం_END
ఖీ_END
రౌ_MID
మ_MID
జేక్ట్_END
చో_BEG
దిం_MID
కొద్_BEG
మెంట్_BEG
దీప్_BEG
గొప్_BEG
ముద్_MID
కాన్_MID
ణిజ్_MID
వాస్_MID
టో_MID
సి_MID
స్టే_BEG
నిం_BEG
నాయ్_END
ధం_MID
సన్_MID
హెం_MID
షు_END
జుం_MID
ఏమ్స్_BEG
లే_END
వీస్_BEG
తూ_END
బుల్_END
లక్_END
టున్_MID
ఫ_MID
జాప్_BEG
మాధ్_BEG
దేళ్_MID
చై_BEG
కాస్_END
మూ_BEG
యో_END
ఈశ్_BEG
నిట్_MID
ఎ_END
సుం_MID
యింట్_END
టై_MID
గౌ_BEG
ఫార్మ్_BEG
ళూ_MID
ధిం_MID
ఛార్_BEG
క్ర_BEG
మాం_BEG
షా_END
కట్_MID
రప్_BEG
రేంద్_MID
విస్_MID
వీ_MID
షం_MID
తి_END
షత్_END
టన్_BEG
న_MID
సుబ్_MID
రయ్_MID
హెల్ప్_BEG
నిప్_BEG
ఎద్_BEG
గట్_BEG
ఎం_BEG
మి_BEG
దోస్_BEG
వేం_MID
ళి_MID
కప్_BEG
చమ్_MID
జేస్_MID
కంట్_BEG
పద్_BEG
తంత్ర్_MID
యప్_MID
చెప్_BEG
రైం_MID
లు_END
హ_BEG
భర్_BEG
కయ్_MID
రోత్_MID
స్థ_MID
థ_MID
నే_BEG
జమ్_BEG
చూ_BEG
డల్_MID
పాట్_MID
లైం_BEG
బ్రిడ్_BEG
సొ_BEG
డీ_END
ణం_END
చేం_MID
హస్_MID
భే_MID
చుర్_MID
టూ_MID
పుస్_MID
గె_BEG
ప్రక్_BEG
భం_BEG
ఫీ_BEG
రుద్_MID
సమ్_BEG
వచ్_MID
విత్_MID
తీశ్_MID
పో_MID
లా_END
శ_BEG
గ్రౌండ్స్_BEG
జె_MID
బర్_MID
ఘాల్_END
రీ_MID
లం_MID
మద్_END
ఢ_MID
ఫ్లై_BEG
చి_BEG
దూర్_END
మాన్_END
వెన్_MID
యూ_END
అన్_BEG
సే_BEG
లివ్_MID
మర్_BEG
డున్_MID
ప్రెస్_BEG
దిద్_MID
టి_MID
గృ_BEG
మవ్_MID
వో_BEG
శక్_BEG
క్రిష్_MID
పై_MID
యాల్_END
తల్_BEG
వెస్_END
ట_MID
ను_BEG
పుట్_BEG
సుల్_BEG
టిక్_BEG
రవ్_BEG
పేస్_END
యి_END
ప్రా_MID
భు_MID
లెక్_MID
శ్ర_MID
యద్_END
ప్రాం_BEG
గీ_BEG
మిన్_END
లర్_END
వై_BEG
ఖో_MID
యర్_BEG
హాన్_MID
ఉల్_BEG
ర_BEG
సృష్_BEG
త్రి_END
జీ_MID
కుస్_MID
శిక్_BEG
జ_MID
నా_BEG
కంప్_BEG
రన్స్_END
జయ్_END
బెల్_BEG
హిల్స్_END
రిబ్_MID
డిట్_END
నల్_END
పొన్_BEG
యిల్_END
సు_BEG
భా_MID
గర్_END
బొబ్_BEG
దోక్_MID
లాగ్_BEG
దో_END
యిం_MID
చక్_MID
బీ_END
మం_END
శాం_BEG
రో_BEG
పూ_MID
భ_BEG
శాస్త్_BEG
ఆస్_BEG
కొ_END
డెభ్_BEG
జక్_BEG
";

@ps = split(/\s+/, $Phoneset);

 foreach (@ps)
  {
    $HashPhone{$_}++;
  }
  chomp(@ps);
my $check = 0;
my $oF = "wordpronunciation";
open(fp_out, ">$oF");

@psyl = &utf2UniCode($eachW);

my $nS = $#psyl + 1;
my %Uni2IT3MAP = (); 
my %it3Type = ();
my %uniqWords = ();
# my $oFDic = "pronunciationDict";
print fp_out "(set! wordstruct '( ";
my $sp = 0;
my $prntStr = "";
my $var ="";
my @outArr=();
my $k=0;
for (my $j = 0; $j < $nS; $j++) {

	if($psyl[$j] eq ""){
		delete $psyl[$j];
	} else {
		$outArr[$k]=$psyl[$j];
		$k++;
	}
}

$nS = @outArr;
for (my $j = 0; $j < $nS; $j++) {
   $tempStr="";
   if ($j == 0 )
   {
	$var = $BegTag;
   }
   elsif ($j == ($nS -1) )
   { 
	$var = $EndTag;
   }
   else
   {
	$var = $MidTag;
   }
   my $word_present = $outArr[$j].$var;
	#print "Word is $word_present \n";
   if($combination eq "phone" && exists $HashPhone{$word_present}) {
	$tempStr = "-x";
   } 
   $sp = 0;
   my $ls = $outArr[$j] ;
   my $change_psyl = $word_present.$tempStr ;

   print fp_out "((";
   print fp_out "\"$change_psyl\"";

   print fp_out ") $sp) ";
}
   print fp_out "))\n";
close(fp_out);

sub utf2UniCode {
	my $file_path = $_[0];
	#print "Processing $utf8FileIn ...\n";
	#open( FILE, "<$file_path" );
	#binmode(FILE);
	my $ENDln = "\n";
	my $line  = ();
	my $t;
	my $syllabified_word;
	my @sentence;
	my $syllabified_sentence;
	my @tempsent;
	my $word  = $_[0];

	chomp($word);
	my $engl   = 0;
	my $otherl = 0;
	#foreach my $word (@words) {
	my @utf8char;
	my $initial = 0;
	my @test;
	my $tempword;
	my $hexword;
	my $decword;
	my $other = 0;
	my $eng   = 0;
        #print "----------------------$word------------------------";
	foreach ( split( //, $word ) ) {
#print( "split word $_ \n");

		push( @utf8char, &string2bin($_) );

	}
#print "utf8char @utf8char";

	my $nutf8char = $#utf8char + 1;

		#$h += $nutf8char;
	for ( my $loop = 0 ; $loop < $nutf8char ; ) {
		$t = 0;
		my $dec_input = &hex2dec( $utf8char[$loop] );
		if ( ( my $value = $dec_input & 128 ) == 0 ) {
			$t = $t | $dec_input;
			$loop++;
			$eng = 1;
		}
		elsif ( ( $value = $dec_input & 224 ) == 192 ) {
			$eng = 1;
			$t   = $t | ( $dec_input & 31 );
			$t   = $t << 6;
			$loop++;

			$t = $t | ( $dec_input & 63 );
			$loop++;
		}

		elsif ( ( $value = $dec_input & 240 ) == 224 ) {
			$other = 1;
			$t     = $t | ( $dec_input & 15 );
			$t     = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t | ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t | ( $dec_input & 63 );
			$loop++;
		}

		elsif ( ( $value = $dec_input & 248 ) == 240 ) {
			$other = 1;

			$t = $t + ( $dec_input & 7 );
			$t = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t + ( $dec_input & 63 );
			$loop++;
		}

		elsif ( ( $value = $dec_input & 252 ) == 248 ) {
			$other = 1;
			$t     = $t + ( $dec_input & 3 );
			$t     = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t + ( $dec_input & 63 );
			$loop++;

		}

		elsif ( ( $value = $dec_input & 254 ) == 252 ) {
			$other = 1;
			$t     = $t + ( $dec_input & 63 );
			$t     = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;
			
			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t         = $t + ( $dec_input & 63 );
			$t         = $t << 6;
			$loop++;

			$dec_input = &hex2dec( $utf8char[$loop] );
			$t = $t + ( $dec_input & 63 );
			$loop++;
		}
		else {
			$loop++;
		}
		#print "t is $t\n";
		@tempArr=$t;
		#print "---------------------@tempArr------------------";
		my $result = &check_language($t);

		#next if ( ( $result !~ true ) );
		my $hex = &dec2hex($t);

		$decword .= " " . $t;
		#print $decword;
		$hexword .= " " . $hex;
		if ( $hex == "C4D" )    #To check if halant present
		{
			$hal = 1;
		}
	}
	my @hextemp     = split( /\s+/,            $hexword );
	my @dectemp     = split( /\s+/,            $decword );
	
	my @combTag=&combineTag(\@dectemp);
	#print "my combTag @combTag\n";
	my @tokenized = &token(\@combTag);
	#print "--------------@hextemp--------------------------";
	my @temp = &rules_GEM(\@tokenized);
	my @finArray = &checkSymbol( \@tokenized, \@temp );
	my $words = " ";
	#$syllabified_sentence .= &syllabify( \@combTag );
	#$syllabified_sentence .= &phonify( \@combTag );
	if($combination eq "phone") {
		
		$syllabified_sentence = &phonify(\@finArray);
	} else {
		$syllabified_sentence = &syllabify(\@finArray);
	}

	return &syllabified_utf8($syllabified_sentence);
}

sub token {
	my @finArr = @{ $_[0] };
	my @utfdata =();
			for ( my $i = 0 ; $i < @finArr ; $i++ ) {
        			if ((3071 < $finArr[$i])&&($finArr[$i] < 3200)){
					#print $unicodevalue[$j];
					if($check1 ==0 && (($finArr[$i] == 3143) &&  ($finArr[$i+1] == 3134))) {
						#print "value is $finArr[$i]";
						#$combTag[$i] = 3019;
						push( @utfdata,3147 );
						$check1 = 1;
						next;
					} elsif ($check1 == 0 && (($finArr[$i] == 3142)  &&  ($finArr[$i+1] == 3134))) {
						#print "value is $finArr[$i]";
						#$combTag[$i] = 3018;
						push( @utfdata,3146 );
						$check1 = 1;
						next;
					} 
					elsif ($check1 == 0 && (($finArr[$i] == 3142)  &&  ($finArr[$i+1] == 3158))) {
						#print "value is $finArr[$i]";
						#$combTag[$i] = 3018;
						push( @utfdata,3148 );
						$check1 = 1;
						next;
					} 
				#print "  $combTag[$i] IS next working \n";
					if($check1 == 0) {
	        				push( @utfdata,$finArr[$i] );
					} else {
						$check1 = 0;
					}
        			} else {
					#print "fire1-fire1\n";
				}
		}
		return @utfdata;

}

sub checkSymbol {
	my @finalArray;
	my $k = 0;
	for ( my $i = 0 ; $i < @{ $_[0] } ; $i++ ) {
		if (
			${ $_[1] }[$i] ne "-"
			&& (   ${ $_[0] }[ $i + 1 ] > &hex2dec("C3C")
				&& ${ $_[0] }[ $i + 1 ] < &hex2dec("C57") )
		  )
		{
			my $temp = ${ $_[1] }[$i];

			#			print "tem is $temp";
			${ $_[1] }[$i] = "-";
			${ $_[1] }[ $i + 1 ] = $temp;
			$finalArray[$k] = ${ $_[0] }[$i];
		}
		elsif ( ${ $_[1] }[$i] ne "-" ) {
			$finalArray[$k] = ${ $_[0] }[$i];
			$k++;
			$finalArray[$k] = ${ $_[1] }[$i];
		}
		else {
			$finalArray[$k] = ${ $_[0] }[$i];
		}
		$k++;
	}

# 	#	print @{$_[1]} ;
	return @finalArray;
}


sub syllabified_utf8 {
	my $syllbified_line = $_[0];
	my @syllabified_words;
	my $phonified_word;
	my @phonified_letters;
	my @temp_array;
	my $phones;
	my @utf8_array;
	my $syllable;
	$syllbified_line =~ s/\. +/\.$ENDln/g;
	@syllabified_words = split(/\s+/,$syllbified_line);
# 	print "Syllabified Word Array : @syllabified_words\n";
	foreach (@syllabified_words) {
		my @temp_syll_array = ();
		my @phonearray = ();
		@temp_syll_array = ($_ =~ m/.../g);
		#print @temp_syll_array;
		foreach $temp(@temp_syll_array) {
		if ($temp eq $uvTagHex)
		{
		$phones .= $uvTagStr;
		}
		elsif ($temp eq $vTagHex)
		{
		$phones .= $vTagStr;
		}
		elsif ($temp eq $ivTagHex)
		{
		$phones .= $ivTagStr;
		}
		elsif ($temp eq $temptag)
		{
		$phones .= $tempstrTag;
		}
		else
		{
		$phones .= chr(hex $temp);
		}
		}
		push(@utf8_array,$phones);
		$phones = "";
		$syllable = "";
	}
#print @utf8_array;
	return @utf8_array;
}


sub string2bin($) {
	return sprintf( "%02x ", ord($_) );
}

sub hex2dec($) {
	eval "return sprintf(\"\%d\", 0x$_[0])";
}

sub check_language
{

	#my @Language_Ranges = @{$_[1]};

	#foreach my $line (@Language_Ranges)
	#{
	my $line   = "Telugu_3072-3199";
	my @values = split( /_/, $line );
	my $lan    = shift(@values);
	foreach my $ran (@values) {
		my @range = split( /-/, $ran );
		# print " $range[0]  ::::: $_[0] \n";
		if ( $range[0] <= $_[0] ) {
			if ( $_[0] <= $range[1] ) {
				return (true);
			} else {
				return false;
			}
		}
	}

	#}
}

sub dec2hex {
	my $decnum = $_[0];
	my ( $hexnum, $tempval );
	while ( $decnum != 0 ) {
		$tempval = $decnum % 16;
		$tempval = chr( $tempval + 55 ) if ( $tempval > 9 );
		$hexnum  = $tempval . $hexnum;
		$decnum  = int( $decnum / 16 );
		if ( $decnum < 16 ) {
			$decnum = chr( $decnum + 55 ) if ( $decnum > 9 );
			$hexnum = $decnum . $hexnum;
			$decnum = 0;
		}
	}
	return $hexnum;
}

sub phonify {
	my $phonified_word;
	for ( my $i = 0 ; $i < @{ $_[0] } ; $i++ ) {
		if (  ${ $_[0] }[$i] > &hex2dec("C03") && ${ $_[0] }[$i] < &hex2dec("C15") ) {
			$phonified_word .= &dec2hex(${ $_[0] }[$i]) . " ";
		}
		elsif ((${ $_[0] }[$i] > &hex2dec("C14") && ${ $_[0] }[$i] < &hex2dec("C3A"))) {
			if (( ${ $_[0] }[$i+1] >= &hex2dec("C3E")) && (${ $_[0] }[$i+1] < &hex2dec("C4D"))) {
				$phonified_word .= &dec2hex(${ $_[0] }[$i]);
			}
			else {
				$phonified_word .= &dec2hex(${ $_[0] }[$i]) . " ";
			}
		}
		elsif ((${ $_[0] }[$i] >= &hex2dec("C3E")) && (${ $_[0] }[$i] <= &hex2dec("C4D"))) {
				$phonified_word =~ s/ $//g;
				$phonified_word .= &dec2hex(${ $_[0] }[$i]) . " ";

		}
		else {
			$phonified_word =~ s/ $//g;
			$phonified_word .= &dec2hex(${ $_[0] }[$i]) . " ";
		}
	}
	#print "phonified_word :::::::::$phonified_word";
	return $phonified_word;
}

sub syllabify {
	my $syllabified_word;
	#my @shortpause;
	#print "called @{ $_[0] } ";
	#my $k=0;
	for ( my $i = 0 ; $i < @{ $_[0] } ; $i++ ) {
#		print "b4 passed ${ $_[0] }[$i]\n";
# Vowel check
		if (  ${ $_[0] }[$i] > &hex2dec("C04") 
			&& ${ $_[0] }[$i] < &hex2dec("C15") )
		{
			$syllabified_word .= &dec2hex(${ $_[0] }[$i] )." ";
# 			print "Inside Vowel check loop\n";
			#$k++;
		}
		elsif( ${ $_[0] }[$i]==&hex2dec("C03")){
#			print "hi\n";
			$syllabified_word .= &dec2hex(${ $_[0] }[$i] );
		}
# Consonant check
		elsif ((${ $_[0] }[$i] > &hex2dec("C14") && ${ $_[0] }[$i] < &hex2dec("C3A")))
		{
# 		print "Inside Consonant check loop\n";
# Halant check - BCD
			if ( ${ $_[0] }[$i+1] == &hex2dec("C4D")) {
				$syllabified_word =~ s/ $//g;
				$syllabified_word .= &dec2hex(${ $_[0] }[$i]);
# 		print "Inside Virama check loop\n";
 			#$k--;	
			}
			elsif ((${ $_[0] }[$i+1] >= &hex2dec("C3E")) && (${ $_[0] }[$i+1] < &hex2dec("C4E")))
			{
				$syllabified_word .= &dec2hex(${ $_[0] }[$i]);
			}
			else {
  			   	#$k++;
				$syllabified_word .= &dec2hex(${ $_[0] }[$i] ). " ";
			   }
		}
		elsif ((${ $_[0] }[$i] >= &hex2dec("C3E"))
				&& (${ $_[0] }[$i] < &hex2dec("C55")
			))
		{       

			if ( ($i == 1 && ${ $_[0] }[$i] == &hex2dec("C4D")) ||  (${ $_[0] }[$i+1] == &hex2dec("C4D"))) {
				$syllabified_word .= &dec2hex(${ $_[0] }[$i]);
                               
                         }
			else {
				#print "comes $k\n";
				if (!((${ $_[0] }[$i-1] > &hex2dec("C14") && ${ $_[0] }[$i-1] < &hex2dec("C3A")))) {
					$syllabified_word =~ s/ $//g;
					$syllabified_word .= &dec2hex(${ $_[0] }[$i]);
				#	$k--;
			 	} else {
				#	$k++;
					$syllabified_word .= &dec2hex(${ $_[0] }[$i] ). " ";
					#print "comes $k\n";
				#	if((${ $_[0] }[$i] == &hex2dec("BCD"))&& (${ $_[0] }[$i-1] == ${ $_[0] }[$i+1])) {
						#print "Short paused $k\n";					
				#		$shortpause[$k]=1;

			   		#}
			 	}

			}

#				$syllabified_word .= ${ $_[0] }[$i]." ";
		}
		elsif (${ $_[0] }[$i] > &hex2dec("C00") || ${ $_[0] }[$i] < &hex2dec("C04"))

		{
			$syllabified_word =~ s/ $//g;
			$syllabified_word .= &dec2hex(${ $_[0] }[$i] ). " ";
		}
		

	}

	#$syllabified_word = join(' ',split(' ',$syllabified_word));
	#print "Syyll is $syllabified_word :::::::::: $forHalant \n";
#print $syllabified_word;
	return $syllabified_word;
}

sub combineTag
{
my @combTag;
my $l=0;
my $k=@{ $_[0] };
# Combine the initial EMPTY char as well
$combTag[$l] = ${ $_[0] }[0];
for(my $j=1;$j<=$k;)
{
if(${ $_[0] }[$j]!=95)
{
$combTag[$l]=${ $_[0] }[$j];
$l++;
$j++;
}
# Check for '_' (95) and 'u' (117)
elsif((${ $_[0] }[$j]==95) && (${ $_[0] }[$j+1]==117))
{
$combTag[$l]=&hex2dec($uvTagHex);
$l++;
$j=$j+3;
}
# Check for '_' (95) and 'i' (105)
elsif((${ $_[0] }[$j]==95) && (${ $_[0] }[$j+1]==105))
{
$combTag[$l]=&hex2dec($ivTagHex);
$l++;
$j=$j+3;
}
# Check for '_' (95) and 'v' (118)
elsif((${ $_[0] }[$j]==95) && (${ $_[0] }[$j+1]==118))
{
$combTag[$l]=&hex2dec($vTagHex);
$l++;
$j=$j+2;
}
else
{
print "Wrong character used for tagging \n";
}
}
# print "CombinedTag:@combTag\n";
return @combTag;
}

sub rules_GEM {#code added for gemination tagging
	for ( my $i = 0 ; $i < @{ $_[0] } ; $i++ ) {
		#print "-${ $_[0] }[$i]-\n";
		if  (( ${ $_[0] }[$i] == &hex2dec("BB1") ) && (${ $_[0] }[ $i + 2 ] == &hex2dec("BB1")) && (${ $_[0] }[ $i + 1 ] == &hex2dec("BCD")))
			{ #Gemination
				#print "@{ $_[0] }\n";
				$tag_voice_unvoiced[$i] = $temp_Tag;
				#print " ${ $_[1] }[ $i ] fire-fire \n";
			}
			elsif (($i>0) && (${ $_[0] }[$i] == &hex2dec("BB1")) && (${ $_[0] }[$i-2] == &hex2dec("BB1"))){
				$tag_voice_unvoiced[$i] = $temp_Tag;
				}
		else {
			$tag_voice_unvoiced[$i] = "-";
			#print "$tag_voice_unvoiced[$i]\n";
		}
	}
#print "@tag_voice_unvoiced--\n";
return @tag_voice_unvoiced;

#ending
}
