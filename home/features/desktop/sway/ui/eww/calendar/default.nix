let
  folder = ".config/eww/widgets/calendar";
  scripts = "${folder}/scripts";
in 
{
  home = {
    file = {
      "${folder}/calendar.yuck".source = ./calendar.yuck;
      "${folder}/calendar.scss".source = ./calendar.scss;
    };
  };
}