# Kubernetes helpers.
#
# --- basics --------------------------------------------------------------
# kg: kubectl get with JSON output parsed into structured data.
#       kg pods
#       kg pod my-pod | get status.containerStatuses
# @complete external routes kg's arguments to the carapace completer; without
# it nushell only completes external commands, so a `def` gets nothing.
@complete external
def --wrapped kg [...rest] { ^kubectl get ...$rest -o json | from json }

alias kga = ^kubecolor get all
alias kgd = ^kubecolor get deployment
alias kgnr = ^kubecolor get nodes
alias kgns = ^kubecolor get namespaces
alias kgp = ^kubecolor get pods
alias kgpvc = ^kubecolor get pvc
alias kgrs = ^kubecolor get replicaset
alias kgs = ^kubecolor get svc
alias kgss = ^kubecolor get statefulset
alias kgsec = ^kubecolor get secrets

alias kgaa = ^kubecolor get all --all-namespaces
alias kgpa = ^kubecolor get pods --all-namespaces

alias kgpw = ^kubecolor get pods --watch
alias kd = ^kubecolor describe
alias kdp = ^kubecolor describe pods
alias kep = ^kubecolor edit pods
alias kdelp = ^kubecolor delete pods

alias kge = ^kubecolor get events --sort-by .lastTimestamp
alias kgew = ^kubecolor get events --sort-by .lastTimestamp --watch

alias kl = ^kubecolor logs
alias klf = ^kubecolor logs -f
alias klf1h = ^kubecolor logs --since 1h -f

alias kaf = ^kubecolor apply -f
alias kapk = ^kubecolor apply -k
alias kdelf = ^kubecolor delete -f
alias kdelk = ^kubecolor delete -k

alias kcuc = ^kubecolor config use-context
alias kccc = ^kubecolor config current-context
alias kcgc = ^kubecolor config get-contexts

# kcns: set the current context's default namespace. This is a def rather than
# an alias so the completer can recognise the name - aliases are expanded
# before the completer runs, so an alias would arrive as plain `kubecolor`.
@complete external
def kcns [namespace: string] {
    ^kubecolor config set-context --current --namespace $namespace
}

alias kpf = ^kubecolor port-forward
alias kcp = ^kubecolor cp

# structured helpers
# yaml output
@complete external
def --wrapped ky [...rest] { ^kubecolor get ...$rest -o yaml }

# kt: parses kubectl's human-readable table straight into a structured
#     table, so no -o json is needed at all. This is the main thing
#     nushell does better than a shell pipe for this.
#       kt pods
#       kt pods -A | where status == "CrashLoopBackOff" | get name
@complete external
def --wrapped kt [...rest] { ^kubecolor get ...$rest | detect columns }

# --- ports of the helpers from zsh functions.zsh -------------------------
def k8s_get_pw [secret?: string] {
    let name = if $secret == null {
        ^kubectl get secret -o name
        | lines
        | each {|l| $l | str replace "secret/" "" }
        | ^fzf --prompt="secret: "
    } else { $secret }

    let pw = kg secret $name
        | get items.0.data.password
        | decode base64
        | decode utf-8
        | str trim -r

    $pw | ^xsel --clipboard --input
    print $"password for ($name) copied to clipboard."
}
