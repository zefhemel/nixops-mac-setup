{
  network.description = "Trivial test network";

  machine = 
    { config, pkgs, ... }:
    { services.httpd.enable = true;
      services.httpd.adminAddr = "alice@example.org";
      services.httpd.documentRoot = "${pkgs.valgrind}/share/doc/valgrind/html";
    };
}
