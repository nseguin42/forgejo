{ config, lib, pkgs, ... }:

let
  serviceName = "forgejo"; # Replace with your actual service name
in {
  systemd.services.${serviceName} = {
    description = "${serviceName} service with docker compose";
    partOf = [ "docker.service" ];
    after = [ "docker.service" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "true";
      WorkingDirectory = "/home/kogasa/forgejo";
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose up -d --remove-orphans";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose down";
    };

    wantedBy = [ "multi-user.target" ];
  };
}

