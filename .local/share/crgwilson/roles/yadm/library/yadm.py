from os.path import isdir

from ansible.module_utils.basic import AnsibleModule


DOCUMENTATION = """
"""

EXAMPLES = """
- name: "Download my dotfiles"
  yadm:
    repo: https://githhub.com/bob/bobs-awesome-dotfiles.git
    dest: /home/bob
    update: true
"""

RETURN = """
"""


def run_cmd(module, cmd, cwd=None):
    (rc, out, err) = module.run_command(cmd, check_rc=True, cwd=cwd)
    if rc != 0:
        module.fail_json(
            msg="Error occurred when running command %s" % (cmd),
            stdout=out,
            stderr=err,
            rc=rc
        )


def clone(module, executable, repo, dest):
    cmd = "%s clone %s" % (executable, repo)
    run_cmd(module, cmd, dest)


def pull(module, executable, dest):
    cmd = "%s pull" % (executable)
    run_cmd(module, cmd, dest)


def main():
    module = AnsibleModule(
        argument_spec=dict(
            repo=dict(required=True),
            dest=dict(type="path"),
            update=dict(type="bool", default=False),
            executable=dict(type="path", default="yadm"),
        ),
        supports_check_mode=True,
    )

    repo = module.params["repo"]
    dest = module.params["dest"]
    update = module.params["update"]
    executable = module.params["executable"]

    result = dict(changed=False, warnings=list())
    yadm_dir = "%s/.local/share/yadm/repo.git" % (dest)

    if isdir(yadm_dir):
        if update:
            pull(module, executable, dest)
            result["changed"] = True
    else:
        clone(
            module,
            executable,
            repo,
            dest,
        )
        result["changed"] = True
    module.exit_json(**result)


if __name__ == "__main__":
    main()
