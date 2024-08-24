_:

{
  users.mutableUsers = true;

  users.users.root = {
    home = "/root";
    uid = 0;
    group = "root";
    # Use `passwd` to change it
    initialHashedPassword = "";
  };
}
