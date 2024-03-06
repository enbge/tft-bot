use warnings;
use MIME::Base64;
use LWP::UserAgent;
use JSON::Parse 'parse_json';
use Time::HiRes qw(sleep);
my $lala = 1;
my $gati = 0;
my $dead = 0;
my $earn;
my $need;
my $alp;
my ($auth,$port) = @{ auth() };
my $ua = LWP::UserAgent->new( ssl_opts=>{verify_hostname=>0}, protocols_allowed=>['https']);
my $header = ['Accept'=>'application/json', 'Content-Type'=>'application/json', 'Authorization'=>"Basic $auth"];
my $boku = ${onegai('GET','lol-summoner/v1/current-summoner',undef)}{displayName};
my @co = (state());
while (1) {
    my $state = state();
    if ($co[-1] ne $state) {
        push@co,$state;
        print "gf: $state\n";
    }
    if ($state eq 'Lobby') {
        onegai('POST','lol-lobby/v2/lobby/matchmaking/search',undef)   
    } elsif ($state eq 'None') {
        onegai('POST','lol-lobby/v2/lobby','{"queueId": 1130}')
    } elsif ($state eq 'Matchmaking') {
        # wait
    } elsif ($state eq 'InProgress') {
        sleep 30;
        if (endgame() == 1){
            miles();
            sleep 15;
            system('taskkill/im "League of Legends.exe"');
            system('taskkill/im "League of Legends.exe"');        
        }
    } elsif ($state eq 'ReadyCheck') {
        onegai('POST','lol-matchmaking/v1/ready-check/accept',undef); 
    } elsif ($state eq 'WaitingForStats') {
        sleep 13;
        onegai('POST','lol-lobby/v2/play-again',undef);
    } elsif ($state eq 'EndOfGame') {
        onegai('POST','lol-lobby/v2/play-again',undef);
    }
  sleep 3;
}
sub state {return onegai('GET','lol-gameflow/v1/gameflow-phase',undef);}
sub onegai { 
  my $url = "https://127.0.0.1:$port/$_[1]";
  my $req = HTTP::Request->new($_[0], $url, $header);
  $req->content($_[2]);
  my $data = $ua->request($req)->content;
  if ($data) {
    return parse_json($data)
  }      
}
sub miles{
    my $mino = int($gati / 60);
    my $seco = $gati % 60;
    print "game $lala dura: $mino:$seco\n";
    my %eko = %{onegai('GET','lol-tft/v2/tft/battlepass',undef)};
  $earn = int($eko{activeMilestone}{pointsEarnedForMilestone});
  $need = int($eko{activeMilestone}{pointsNeededForMilestone});
    print "earned: $earn\n";
  print "needed: $need\n";
    $lala++;
}
sub endgame {
  my $req = HTTP::Request->new(GET=>'https://127.0.0.1:2999/liveclientdata/allgamedata') or die $!;
  if ($req && $ua->request($req)->content) {
    my %data = %{parse_json($ua->request($req)->content)};
    $alp = $data{allPlayers};
    $gati = int($data{gameData}{gameTime});
        foreach my $x (@{$alp}) {
      foreach my $c (keys %{$x}) {
        if ($x->{summonerName} eq $boku) {
                    $dead = $x->{isDead};
          last;
        }
      }
    }
  }
    return $dead;    
}
sub auth {
  my $proc = `WMIC path win32_process get Caption,Commandline | find "--remoting-auth-token="`;
  if ($proc =~ /--remoting-auth-token=(\S+)".*?--app-port=(\d+)/) {
    return [ encode_base64(qq(\x72\x69\x6f\x74:$1)), $2 ]
  }
} 