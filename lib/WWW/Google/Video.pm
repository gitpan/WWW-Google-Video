package WWW::Google::Video;

use strict;
use warnings;
use vars qw($VERSION);
use LWP::Simple;
$VERSION = '0.3';

sub new { bless {}, $_[0]; }
sub fetch {
my $url=get $_[1];
my @pic;
if($url=~/.+\Qgoogleplayer.swf?videoUrl\E\\u003d([^\\"]+).+/s) {
    ${$_[0]}{url}=$1;
    ${$_[0]}{url}=~tr/+/ /;
    ${$_[0]}{url}=~s/\\u003d/=/g;
    ${$_[0]}{url}=~s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
}
if($url=~/\Q<div id="pvprogtitle"> \E(.+?)\Q<\/div>\E/s) {
    ${$_[0]}{name}=$1;
    ${$_[0]}{name}=~s/<[^<]+>//g;
}
    $url=~s/((\d+ hr )?(\d+ min )?(\d+ sec)?)\s*\-  \w{3}/${$_[0]}{length}=$1/e;
    $url=~s/\Q<img src="\E(http:\/\/video.google.com\/ThumbnailServer[^"]+)"/my $tmp=$1;$tmp=~s#&amp;#&#g;push(@pic,$tmp)/eg;
    ${$_[0]}{pic}=\@pic;
}

1;

__END__

=head1 NAME

WWW::Google::Video - Fetch the Google Video Information

=head1 SYNOPSIS

 use WWW::Google::Video;

 $foo=new WWW::Google::Video;

 $foo->fetch('http://video.google.com/videoplay?docid=1808273720725631796');
 # The Google Video Page URL, such as http://video.google.com/videoplay?docid=blahblahblah

 print $foo->{url},"\n";      # Google Video FLV Original File URL !!
 print $foo->{length},"\n";   # Video Length Information
 print $foo->{name},"\n";     # Video Name Information

 foreach(@{ $foo->{pic} }){     # By using Reference to an Array
             print $_,"\n";     # To show the preview pictures.
 }

=head1 DESCRIPTION

The C<WWW::Google::Video> is a class implementing a interface for
fetch the Google Video Information.

To use it, you should create C<WWW::Google::Video> object and use its
method fetch(), to fetch the information of Video.

It uses C<LWP::Simple> for making request to Google.

=head1 COPYRIGHT

Copyright 2005,2006 by Lilo Huang All Rights Reserved.

You can use this module under the same terms as Perl itself.

=cut
