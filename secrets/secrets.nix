let
  adamczykb = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDwanZCla3F4MO71DwCSfUdaTgEDNYTSJdF8aE6WXhHf adamczyk.b@perun";
  users = [adamczykb];
  # system1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPJDyIr/FSz1cJdcoW69R+NrWzwGK/+3gJpqD1t8L2zE";
  # systems = [system1];
in {
  "spotify.age".publicKeys = [adamczykb];
  # "secret.age".publicKeys = [user1];
}
