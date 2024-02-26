{ pkgs, ... }:

{
  services.postgres = {
    enable = true;
    package = pkgs.postgresql_15;
    initialScript = "CREATE USER phoenix WITH PASSWORD 'phoenix' CREATEDB;;";
  };
}