let
  perun-user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICVw2iutcGsoc+y9QkU0EJ7Sn0raIrGxNt4zdRdficKr adamczykb@perun";
  veles-user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwanZCla3F4MO71DwCSfUdaTgEDNYTSJdF8aE6WXhHf adamczykb@veles";

  perun = [perun-user];

  veles = [veles-user];
in {
  age.identityPaths = "/persist/home/adamczykb/.ssh/id_ed25519";
}
