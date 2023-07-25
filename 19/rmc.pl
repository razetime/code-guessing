use Getopt::Long; # qw(:config no_ignore_case no_auto_abbrev); # https://metacpan.org/pod/Getopt::Long#Command-Line-Options,-an-Introduction
use Pod::Usage;
use File::Path;

# if (not @ARGV) {
# 	# print $0;
# 	unlink($0);
# }

$frc = '';
$pr  = '';
$pri = '';
$int = '';
$ofs = '';
$npr = '';
$pr = '';
$rec = '';
$emp = '';
$ver = '';
my $help = 0;
my $man = 0;
GetOptions(
	'help|?' => \$help,
	man => \$man) or pod2usage(2);
# print "\$frc: $frc\n";
# print "\$ver: $ver\n";
# print "\$pr : $pr \n";
# print "\$pri: $pri\n";
# print "\$int: $int\n";
# print "\$rec: $rec\n";
# print "\$emp: $emp\n";
pod2usage(1) if $help;
pod2usage(-verbose => 2) if $man;
# sub ynprompt {
# 	print $_;
# 	my $in = <STDIN>;
# 	return $in[0] =~ /y/i
# }

# if (not $int) {
# 	if ($pr) {
# 		$int = 'always';
# 	} elsif ($pri) {
# 		$int = 'once'
# 	}
# }
# https://github.com/coreutils/coreutils/blob/master/src/rm.c
# if (not @ARGV) {
# 	print "rm: missing operand\nTry 'rm --help' for more information.\n";
# 	exit 1;
# }
# if (($rec or (scalar @ARGV) > 3) and $int == 'once') {
# 	ynprompt("Delete files @ARGV? ");
# }
# for my $fname (@ARGV) {
# 	if (not -e $fname) {
# 		print "rm: cannot remove '$fname': No such file or directory\n";
# 	} if (-f $fname) {
# 		if ($ver) {
# 			print "removed '$fname'";
# 		}
# 		unlink($fname)
# 	} else {
# 		if (-d $rec) {
# 			print "rm: cannot remove '$fname': Is a directory\n";
# 		} else {
# 			rmtree $fname, $ver, 1;
# 			if ($ver) {
# 				print "removed directory '$fname'";
# 			}
# 		}
# 	}
# } 



__END__
 
=head1 NAME
 
sample - Using GetOpt::Long and Pod::Usage
 
=head1 SYNOPSIS
 
sample [options] [file ...]
 
 Options:
   -help            brief help message
   -man             full documentation
 
=head1 OPTIONS
 
=over 4
 
=item B<-help>
 
Print a brief help message and exits.
 
=item B<-man>
 
Prints the manual page and exits.
 
=back
 
=head1 DESCRIPTION
 
B<This program> will read the given input file(s) and do something
useful with the contents thereof.
 
=cut