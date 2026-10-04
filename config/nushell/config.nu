# Nushell configuration
$env.config.show_banner = false

# configure prompt
$env.STARSHIP_CONFIG = ($nu.home-dir | path join ".config" "nushell" "starship.nu.toml")
$env.STARSHIP_SHELL = "nu"
$env.PROMPT_COMMAND = {starship prompt}

# vi modes
$env.config.edit_mode = "vi"
$env.config.cursor_shape = { vi_insert: "line", vi_normal: "block" }

# history
$env.config.history.max_size = 50000
$env.config.history.file_format = "sqlite"

# tables
$env.config.table.trim = { methodology: "truncating", truncating_suffix: "..." }

# completions
# Argument completion for external commands, via carapace (`yay -S carapace-bin`).
# LENIENT stops carapace erroring on flags its specs don't know about - notably
# `kubectl config set-context --current`.
$env.CARAPACE_LENIENT = 1

let carapace_completer = {|place|
    let cmd = $place.command
    # carapace dispatches on the command name, so our wrappers have to be
    # presented as the binary they stand for. Note that aliases are already
    # expanded by the time we see them, so only `def`s can be matched by name.
    if $cmd.0? in ["kg", "ky", "kt"]  {
        # kg/kt/ky is `kubectl get`
        carapace kubectl nushell kubecolor get ...($cmd | skip 1) | from json
    } else if $cmd.0? == "kcns" {
        # carapace's specs are also inconsistent about a leading token: the `get`
        # family wants one, `config set-context` must not have one.
        carapace kubectl nushell config set-context --current --namespace ...($cmd | skip 1) | from json
    } else {
        # kubecolor has no carapace spec of its own; dispatch on kubectl.
        # carapace then runs the real kubectl for its queries, so this keeps
        # kubecolor's colours for actual output.
        let name = if $cmd.0? == "kubecolor" { "kubectl" } else { $cmd.0? }
        carapace $name nushell ...$cmd | from json
    }
}
$env.config.completions.external.completer = $carapace_completer

# global aliases
alias cl = ^clear
alias g = ^lazygit

# source k8s alias
source ($nu.default-config-dir | path join "k8s.nu")
