_:
{
  # Allow using `passwd` on users to get into them.
  users.mutableUsers = true;

  users.users.root = {
    home = "/root";
    uid = 0;
    group = "root";
    # By default, allow password-less login, to be used with `passwd`.
    # TODO: Make this use a SOPS secret with a password instead.
    initialHashedPassword = "";
  };
}
