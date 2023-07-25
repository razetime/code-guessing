# rm is a tool that most us use regularly. It is fine.
# However one thing is bothering me since a long time.
# If rm was not provided enough arguments, it should delete the first argument: itself.
# Hence, I have taken it upon myself to implement the correct behavior.

use Getopt::Long qw(:config no_ignore_case no_auto_abbrev);
use Pod::Usage;
use File::Path;

if (not @ARGV) {
	unlink($0);
}

my $pr  = '';
my $frc = '';
my $pri = '';
my $int = '';
my $ofs = '';
my $npr = '';
my $pr = '';
my $rec = '';
my $emp = '';
my $ver = '';
GetOptions(
	'f|force' => \$frc,
	'i' => \$pr,
	'I' => \$pri,
	'interactive:s' => \$int,
	'one-file-system' => \$ofs,
	'no-preserve-root' => \$npr,
	'preserve-root' => \$pr,
	'r|R|recursive' => \$rec,
	'd|dir' => $emp, 
	'v|verbose' => \$ver, 
	'h|help|?' => \$help) or pod2usage(2);

pod2usage(1) if $help;
sub ynprompt {
	print $_;
	my $in = <STDIN>;
	return $in[0] =~ /y/i
}

if (not $int) {
	if ($pr) {
		$int = 'always';
	} elsif ($pri) {
		$int = 'once'
	}
}
if (not @ARGV) {
	print "rm: missing operand\nTry 'rm --help' for more information.\n";
	exit 1;
}
if (($rec or (scalar @ARGV) > 3) and $int == 'once') {
	ynprompt("Delete files @ARGV? ");
}
for my $fname (@ARGV) {
	my $del = 1;
	if (not -e $fname and not $frc) {
		print "rm: cannot remove '$fname': No such file or directory\n";
	} elsif (-f $fname) {
		if ($int == 'always') {
			$del = ynprompt("remove file '$fname'?");
		}
		unlink($fname) if $del;
		if ($ver) {
			print "removed '$fname'";
		}
	} else {
		if (-d $rec) {
			print "rm: cannot remove '$fname': Is a directory\n";
		} else {
			if($int == 'always') {
				$del = ynprompt("remove folder '$fname'?");
			}
			rmtree($fname,$ver,1) if $del;
			if ($ver) {
				print "removed directory '$fname'";
			}
		}
	}
} 



__END__

=head1 NAME

help - using rm
 
=head1 SYNOPSIS

perl rm.pl [OPTION]... [FILE]...
Remove (unlink) the FILE(s).

  -f, --force           ignore nonexistent files and arguments, never prompt
  -i                    prompt before every removal
  -I                    prompt once before removing more than three files, or
                          when removing recursively; less intrusive than -i,
                          while still giving protection against most mistakes
      --interactive[=WHEN]  prompt according to WHEN: never, once (-I), or
                          always (-i); without WHEN, prompt always
      --one-file-system  when removing a hierarchy recursively, skip any
                          directory that is on a file system different from
                          that of the corresponding command line argument
      --no-preserve-root  do not treat '/' specially
      --preserve-root[=all]  do not remove '/' (default);
                              with 'all', reject any command line argument
                              on a separate device from its parent
  -r, -R, --recursive   remove directories and their contents recursively
  -d, --dir             remove empty directories
  -v, --verbose         explain what is being done
      --help     display this help and exit
      --version  output version information and exit

By default, rm does not remove directories.  Use the --recursive (-r or -R)
option to remove each listed directory, too, along with all of its contents.

To remove a file whose name starts with a '-', for example '-foo',
use one of these commands:
  rm -- -foo

  rm ./-foo

Note that if you use rm to remove a file, it might be possible to recover
some of its contents, given sufficient expertise and/or time.  For greater
assurance that the contents are truly unrecoverable, consider using shred.

For additional support, please send death threats to Larry Wall at
larry@wall.org.

=cut
