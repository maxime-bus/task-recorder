# Requirements

The [stack tool](https://docs.haskellstack.org/en/stable/README/#how-to-install) 
must be installed on your machine.

# How to build it

```bash
stack build
```

# How to run it

```bash
cd /path/to/project
stack run <command>
```

The `command` must be one of the following :
* `init` : It creates the file `$HOME/.tasks`.
  It must be created before using other commands.
* `log "<your topic>"` : It adds a task marked 
  as *in progress* in the file, with a start date.
  It also closes the last known task.
* `log your topic`: Same as above, but don't require
  `"` symbol. Beware of the characters you type that
  might interpreted by your shell.
* `log display`: Display the content of the file. 
 
## Examples

```bash
# creates the file $HOME/.tasks
stack run init 

# logs a task into the file
stack run log "my first task"

# logs a task into the file - alternate usage
stack run log my second task

# displays the content of the file
stack run log display
```

# How to install user-wide

In order to avoid moving to the project folder, and use the command widely, you need to invoke :

```bash
stack install
```

It will generate a binary under `$HOME/.local/bin/task-recorder-exe`. You must have `$HOME/.local/bin`
included in your `$PATH`.

Then, you'll invoke the command like this :

```bash
# creates the file $HOME/.tasks
task-recorder-exe init 

# logs a task into the file
task-recorder-exe log "my first task"

# logs a task into the file - alternate usage
task-recorder-exe log my second task

# displays the content of the file
task-recorder-exe log display
```
