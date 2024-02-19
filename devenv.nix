{ pkgs, ... }:

{
  services.postgres = {
    enable = true;
    package = pkgs.postgresql_15;
    # initialDatabases = [{ name = "mydb"; }];
    initialScript = "CREATE USER phoenix WITH PASSWORD 'phoenix' CREATEDB;;";
  };
}