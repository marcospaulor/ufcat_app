{pkgs}: {
  channel = "unstable";
  packages = [
    pkgs.flutter319
    pkgs.jdk17
    
  ];
  idx.extensions = [
    
  ];
  idx.previews = {
    previews = [
      {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "web-server"
          "--web-hostname"
          "0.0.0.0"
          "--web-port"
          "$PORT"
        ];
        id = "web";
        manager = "flutter";
      }
      {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "android"
          "-d"
          "emulator-5554"
        ];
        id = "android";
        manager = "flutter";
      }
      {
        id = "ios";
        manager = "ios";
      }
    ];
  };
}