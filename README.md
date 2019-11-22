# Tmux Plugin - get cpu model name and count

This is an plugin that fetching cpu info of the server, and count cpu.

This plugin is compatible with Tmux plugin manager([TPM](https://github.com/tmux-plugins/tpm))

This pllugin should work with any themes well.

# Installation
## Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

### Notice:

Due to using the command set -g**a** status-left / status-right 

`And it would be better put tmux-cpu-model config lines **AFTER** `status style like` setup !`

Status left / right length will be added by 40 automatically, because this plugin will use 40 characters


### Requirements:

Make sure set these config lines **AFTER** `theme plugin`

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'charlietag/tmux-cpu-model'

Hit `prefix + I` to fetch the plugin and source it.

CPU model name and counts will now display in `status-left` or `status-right`, after the config setup and reloaded.

## Manual Installation

Clone the repo:

    $ git clone https://github.com/charlietag/tmux-cpu-model.git ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/cpu-model.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf

CPU model name and counts will now display in `status-left` or `status-right`, after the config setup and reloaded.


# Examples

tmux-cpu-mode-left:<br/>
![tmux-cpu-mode-left](/screenshots/tmux-cpu-mode-left.png)

tmux-cpu-mode-right:<br/>
![tmux-cpu-mode-right](/screenshots/tmux-cpu-mode-right.png)


# Customization

Here are all available options with their default values:

```bash
@cpu-model-mode 'right' # [ left | right | none ]
@cpu-model-colour 'fg=colour232,bg=colour2,bold'    # define style for the displayed cpu info
```


# Usage

Sample config in ~/.tmux.conf

```bash
# For installing plugin - tmux-cpu-model --- Must put these lines after plugins which change status-style like powerline-themes
# ... theme plugins before tmux-cpu-model plugin...
set -g @plugin 'charlietag/tmux-cpu-model'

# Automatically **append** cpu model into "status-left" or "status-right"
set -g @cpu-model-mode 'right' # [ left | right | none ]
set -g @cpu-model-colour 'fg=colour232,bg=colour2,bold'
```

Reload tmux config and check your cpu model name and counts

# Other goodies

- [tmux-themes](https://github.com/charlietag/tmux-themes) - simple colorful theme made by CharlieTag


# License

[MIT license](https://opensource.org/licenses/MIT)
