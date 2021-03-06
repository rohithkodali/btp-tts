#!/usr/bin/perl 
#no warnings;
#use utf8;
use Encode;

$eachW = $ARGV[0];

my $oF = "wordpronunciation";
open(fp_out, ">$oF");
open(fwr, '>rag_pho');
@psyl = &utf2UniCode($eachW);
my $nS = $#psyl + 1;
my %Uni2IT3MAP = (); 
my %it3Type = ();
my %uniqWords = ();

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
%phone2itrans=(
"అ" => "a"  , 
"ఆ" => "aa" ,
"ఇ" => "i"  ,
"ఈ" => "ii" ,
"ఉ" => "u",
"ఊ" => "uu",
"ఋ" => "rq",
"ఎ" => "e" ,
"ఏ" => "ee",
"ఐ" => "ai",
"ఒ" => "o"  ,
"ఓ" => "oo" ,
"ఔ" => "au" ,
"క" => "k"  ,
"ఖ" => "kh"  ,
"గ" =>  "g" ,
"ఘ" =>  "gh" ,
"ఙ" => "ng"	,
"చ" => "c"  ,
"ఛ" => "ch"  ,
"జ" => "j"  ,
"ఝ" => "jh"  ,
"ఞ"	=> "nj" ,
"ట"	=> "tx" ,
"ఠ"	=> "txh" ,
"డ"	=> "dx" ,
"ఢ"	=> "dxh" ,
"ణ"	=> "nx",
"త"	=> "t" ,
"థ"	=> "th" ,
"ద"	=> "d" ,
"ధ"	=> "dh" ,
"న"	=> "n",
"ప"	=> "p" ,
"ఫ"	=> "ph" ,
"బ"	=> "b" ,
"భ"	=> "bh" ,
"మ"	=> "m",
"య"	=> "y",
"ర"	=> "r",
"ల"	=> "l",
"వ"	=> "w" ,
"ళ"	=> "lx",
"ఱ"	=> "rx",
"ன"	=> "n" ,
"శ"	=> "sh",
"ష"	=> "sx",  
"స"	=> "s" ,
"హ"	=> "h" ,
"ా" => "aa" ,
"ి" => "i"  ,
"ీ" => "ii" ,
"ు" => "u" ,
"ూ" => "uu",
"ృ" => "rq",
"ౄ" => "rq",
"ె" => "e" ,
"ే" => "ee",
"ై" => "ai",
"ొ" => "o" ,
"ో" => "oo",
"ౌ" => "au",
"ం" => "q",
"్" => "MEI",
#"ஃப" => "f" ,
"ః" => "hq",
);
my %wide2itrans=();
while (($key, $value) = each(%phone2itrans)){
     #print $key.", ".$value."\n";
     $new_key=ord(decode('UTF-8', $key));
     #print "The new key = $new_key\n";
     $wide2itrans{$new_key}=$value;
}
#print "Print the new hash\n";
while (($key, $value) = each(%wide2itrans)){
     #print $key.", ".$value."\n";
}
#print "hello world\n";
for (my $j = 0; $j < $nS; $j++) {
   $tempStr="";
   my $word_present = $outArr[$j];
	#print "Word is $word_present \n";
   $sp = 0;
   my $ls = $outArr[$j] ;
   my $change_psyl = $word_present.$tempStr ;
   $change_psyl =~ s/[\x0-\x7f]//g; 
   
   my $characters = encode('UTF-8',"\"$change_psyl\"");
   print "[$characters ]\n";

   $output_english_string=" ";
   my $count = numPhonesInSyl($characters);

   print fp_out "((";
   print fp_out "$output_english_string";
   print fwr "$output_english_string\n";

   print fp_out ") $sp) ";
}
   print fp_out "))\n";
close(fp_out);

sub utf2UniCode {
	my $file_path = $_[0];
	open( FILE, "<$file_path" );
	binmode(FILE);
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
	my @utf8char;
	my $initial = 0;
	my @test;
	my $tempword;
	my $hexword;
	my $decword;
	my $other = 0;
	my $eng   = 0;
        
	foreach ( split( //, $word ) ) {
#print( "split word $_ \n");

		push( @utf8char, &string2bin($_) );

	}
#print "utf8char @utf8char";

	my $nutf8char = $#utf8char + 1;

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
		@tempArr=$t;
		#print @tempArr;
		#my $result = &check_language($t);

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
	
	#print "@dectemp\n";
	my @tokenized = &token(\@dectemp);
	my $words = " ";
	#print "@tokenized\n";
	$syllabified_sentence = &syllabify(\@tokenized);
	#print $syllabified_sentence;
	return &syllabified_utf8($syllabified_sentence);
}

sub token {
	my @finArr = @{ $_[0] };
	my @utfdata =();
			for ( my $i = 0 ; $i < @finArr ; $i++ ) {
        			if ((3072 < $finArr[$i])&&($finArr[$i] < 3199)){
					#print $unicodevalue[$j];
					if($check1 ==0 && (($finArr[$i] == 3015) &&  ($finArr[$i+1] == 3006))) {
						push( @utfdata,3019 );
						$check1 = 1;
						next;
					} elsif ($check1 == 0 && (($finArr[$i] == 3014)  &&  ($finArr[$i+1] == 3006))) {
						push( @utfdata,3018 );
						$check1 = 1;
						next;
					} 
					elsif ($check1 == 0 && (($finArr[$i] == 3014)  &&  ($finArr[$i+1] == 3031))) {
						push( @utfdata,3020 );
						$check1 = 1;
						next;
					} 
					if($check1 == 0) {
	        				push( @utfdata,$finArr[$i] );
					} else {
						$check1 = 0;
					}
        			} else {
				}
		}
		return @utfdata;

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
		$phones .= chr(hex $temp);
		}
		push(@utf8_array,$phones);
		$phones = "";
		$syllable = "";
	}
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

	my $line   = "Tamil_2944-3071";
	my @values = split( /_/, $line );
	my $lan    = shift(@values);
	foreach my $ran (@values) {
		my @range = split( /-/, $ran );
		if ( $range[0] <= $_[0] ) {
			if ( $_[0] <= $range[1] ) {
				return (true);
			} else {
				return false;
			}
		}
	}

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
		elsif( ${ $_[0] }[$i]==&hex2dec("B83")){
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

# sub routines ============================
sub numPhonesInSyl($) {
    my ($string) = @_;
    #remove all non-ascii characters
    $string =~ s/[\x0-\x7f]//g;
    #print "The string is $string\n";
    my $characters = decode('UTF-8', $string);
    my $numChar=0;
    use constant {
        VOWEL => 0,
        CONSONANT => 1,
        MATRA => 2,
        MEI => 3,
        OTHERS => 4,
    };
    my $previous=-1;
    my @tamil_array;
    my $index=0;
    for (split(//, $characters)) {
        my $var=ord;
        #print "The var is $var \n";
        $tamil_array[$index]=$var;
        $index++;
        if($var>=ord(decode('UTF-8', "అ")) && $var<=ord(decode('UTF-8', "ఔ"))) {
            #printf("It is a vowel\n");
            $previous = VOWEL;
            #Give extra states for composite vowels
            if($var==ord(decode('UTF-8', "ఐ"))) {$numChar++; }
            if($var==ord(decode('UTF-8', "ఔ"))) {$numChar++; }
        }
        elsif ($var>=ord(decode('UTF-8', "క")) && $var<=ord(decode('UTF-8', "హ"))) {
            #printf("It is a consonant\n");
            if($previous == CONSONANT) { $numChar++; };
            $previous = CONSONANT;
            #Give etra states for composite consonants
            if($var==ord(decode('UTF-8', "ఙ"))) {$numChar++; }
            if($var==ord(decode('UTF-8', "ఞ"))) {$numChar++; }
        }
        elsif ($var>=ord(decode('UTF-8', "ా")) && $var<=ord(decode('UTF-8', "ౌ"))) {
            #printf("It is a matra\n");
            $previous = MATRA;
        }
        elsif ( $var == ord(decode('UTF-8', "్"))) {
            #printf("It is a MEI\n");
            $numChar--; #for MEI need not count so decrease by one
            $previous = MEI;
        }
        else {
            #printf("It is Something else\n");
            $previous = OTHERS;
        }
        $numChar++;
    }

    if($previous == CONSONANT) { $numChar++; };

    #print "the array\n";
    for(my $i=0;$i<$index;$i++) {
        my $l_var = $tamil_array[$i];
        my $l_var_next = $tamil_array[$i+1];
       
        if($l_var==ord(decode('UTF-8', "్"))) {
            #print "Current is mei no need to output\n";
        }
        else {
            #if current is consonant and next is either matra or mei just output as it is
            if($l_var>=ord(decode('UTF-8', "క")) && $l_var<=ord(decode('UTF-8', "హ"))) {
                #add exception for "ஃப"
		if($l_var==ord(decode('UTF-8', "ప")) && $tamil_array[$i-1]==ord(decode('UTF-8', "ః"))) {
                       #if the next characters is MEI then do not print anything else print a
                       if ($tamil_array[$i+1]==ord(decode('UTF-8',"్"))) {
			#do not print anything
			#print "I am in the exception\n";
                        }
                        else {
		            $output_english_string .=" \"a\" ";
                        }
		}
        else {
		        if( $l_var_next==ord(decode('UTF-8', "్"))
		         || ($l_var_next>=ord(decode('UTF-8', "ా")) && $l_var_next<=ord(decode('UTF-8',"ౌ" ))) ) {
		            #print "Next is either matra or MEI so output [" . $wide2itrans{$l_var} ."]\n";
		            $output_english_string .="\"$wide2itrans{$l_var}\" ";
		        }
		        else {
		            #print "Next must be vowel or consonant so add a [". $wide2itrans{$l_var} ." a]\n";
		            $output_english_string .="\"$wide2itrans{$l_var}\" \"a\" ";
		        }
		}#end of else add exception
            }
            #if current is  either matra or  vowel output as it is
            else {
                #print "Just output it[" . $wide2itrans{$l_var} ."]\n";
                $output_english_string .="\"$wide2itrans{$l_var}\" ";
            }
        }

    }
    #print "\n";
    #print "The output string is:[$output_english_string]\n";

    if($numChar <= 0) {
        return 1;
    }
    else {
        return ($numChar);
    }
}
