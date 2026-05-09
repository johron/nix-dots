{ pkgs, lib, ... }:

{
  programs.wofi = {
    style = ''
    * {
      border: 0;
      font-family: "JetBrainsMono Nerd Font", "Material Symbols Rounded";
      font-size: 12px;
      font-weight: 700;
    }

    window {
      background-color: rgba(10,1,1,0.999);

      /*border-radius: 12px;*/
      margin: 0px;
    }

    #outer-box {
      margin: 0px;
      padding: 0px;
      border: none;
      background-color: transparent;
    }

    #input {
      margin: 14px;
      padding: 12px 16px;

      color: #eeeeee;
      font-weight: 600;

      background: rgb(20,2,2);

      border-radius: 12px;
      box-shadow: inset 0 0 0 1px rgba(255,255,255,0.03);
    }

    #scroll {
      margin: 0px;
      border: none;
    }

    #inner-box {
      margin: 0px 10px 10px 10px;
      border: none;
      background-color: transparent;
    }

    #entry {
      padding: 12px 14px;
      margin: 4px 0px;

      border-radius: 12px;

      background-color: transparent;

      transition: all 120ms ease;
    }

    #entry:selected {
      background: rgb(25,2,2);
    }

    #text {
      margin-left: 12px;
      color: #eaeaea;
    }

    #text:selected {
      color: #ffffff;
    }

    #img {
      margin-right: 10px;
    }

    scrollbar {
      opacity: 0;
    }
  '';
  };
}