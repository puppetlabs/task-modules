# Task Modules

This repository provides a control repo with a collection of task modules for
getting started with Puppet tasks. The tasks in this module can be used both
with `bolt task run` on the command line and in Puppet Plans. This repository
also contains a few utility functions for use in plans. 

## Installation and usage

Configure this repository or a fork as your r10k control repo or clone and run
`r10k puppetfile install` command.  If using with bolt set the `--modulepath
$INSTALL_LOCATION/site:$INSTALL_LOCATION/modules` to add these module to the
modulepath.

## Usage

The examples below give some hints on how to use the contents of this
repo. All examples assume that the `repo` shell variable is set to the
toplevel directory of the checkout of this repository, and that `nodes`
contains a comma-separated list of the nodes on which a task or a plan
should be run.

### Tasks

Each of these tasks can be run with `bolt --modules $repo --nodes $nodes
task run <task_name>`. You can find out more information about the
parameters to pass to the tasks from the `init.json` file in each task's
directory.

| Name | Purpose | Requirements on the target nodes |
|------|---------|--------------|
| `install_puppet` | Install the open-source Puppet agent | RedHat- or Debian-derived Linux distro |
| `package` | Manipulate packages | Puppet must be installed |
| `resource` | Retrieve the state of resources | Puppet must be installed |
| `service` | Manipulate services | Puppet must be installed |
| `facter_task` | fetch a fact value | Facter must be installed |
| `minifact` | Retrieve basic node facts | Bash must be installed |

### Plans

#### minifact

The `minifact` module also contains a plan that lists basic node
information. It is not necessary to have Puppet installed on target nodes
for this. You can run the plan with

```
bolt --modules $repo plan run minifact::info nodes=$nodes
```

### Functions

The following functions are available for use in your plans:

| Function | Purpose |
|------|---------|
| `util::print(String $message)` | Print a message on the console |
| `util::exit(Integer $exitcode = 0)` | Exit bolt immediately |
| `util::error(String $message, Integer $exitcode = 1)` | Print the message and exit with the given exitcode |
