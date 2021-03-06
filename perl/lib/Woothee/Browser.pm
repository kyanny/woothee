package Woothee::Browser;

use strict;
use warnings;
use Carp;

use Woothee::Util qw/update_map update_category update_version update_os/;
use Woothee::DataSet qw/dataset/;

sub challenge_msie {
    my ($ua,$result) = @_;

    return 0 if index($ua, "compatible; MSIE") < 0;

    my $version;
    if ($ua =~ m{MSIE ([.0-9]+);}o) {
        $version = $1;
    }
    else {
        $version = Woothee::DataSet->const('VALUE_UNKNOWN');
    }
    update_map($result, dataset('MSIE'));
    update_version($result, $version);
    return 1;
}

sub challenge_safari_chrome {
    my ($ua,$result) = @_;

    return 0 if index($ua, "Safari/") < 0;

    my $version = Woothee::DataSet->const('VALUE_UNKNOWN');

    if ($ua =~ m{Chrome/([.0-9]+)}o) {
        # Chrome
        $version = $1;
        update_map($result, dataset("Chrome"));
        update_version($result, $version);
        return 1;
    }

    # Safari
    if ($ua =~ m{Version/([.0-9]+)}o) {
        $version = $1;
    }
    update_map($result, dataset("Safari"));
    update_version($result, $version);
    return 1;
}

sub challenge_firefox {
    my ($ua,$result) = @_;

    return 0 if index($ua, "Firefox/") < 0;

    my $version;
    if ($ua =~ m{Firefox/([.0-9]+)}o) {
        $version = $1;
    }
    else {
        $version = Woothee::DataSet->const('VALUE_UNKNOWN');
    }
    update_map($result, dataset("Firefox"));
    update_version($result, $version);
    return 1;
}

sub challenge_opera {
    my ($ua,$result) = @_;

    return 0 if index($ua, "Opera") < 0;

    my $version;
    if ($ua =~ m{Opera[/ ]([.0-9]+)}o) {
        $version = $1;
    }
    else {
        $version = Woothee::DataSet->const('VALUE_UNKNOWN');
    }
    update_map($result, dataset("Opera"));
    update_version($result, $version);
    return 1;
}

sub challenge_sleipnir {
    my ($ua,$result) = @_;

    return 0 if index($ua, "Sleipnir/") < 0;

    my $version;
    if ($ua =~ m{Sleipnir/([.0-9]+)}o) {
        $version = $1;
    }
    else {
        $version = Woothee::DataSet->const('VALUE_UNKNOWN');
    }
    update_map($result, dataset("Sleipnir"));
    update_version($result, $version);

    # Sleipnir's user-agent doesn't contain Windows version, so put 'Windows UNKNOWN Ver'.
    # Sleipnir is IE component browser, so for Windows only.
    my $win = dataset("Win");
    update_category($result, $win->{Woothee::DataSet->const('KEY_CATEGORY')});
    update_os($result, $win->{Woothee::DataSet->const('KEY_NAME')});

    return 1;
}

1;
