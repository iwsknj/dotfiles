#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# refere to suin
# https://suin.io/568
# zshrcのauto_cdと組み合わせることでディレクトリだけ入力すると移動できる
cdpath=(
    $HOME/Workspace/Docker(N-/)
	$HOME/Workspace/Docker/spreadi(N-/)
	$HOME/Workspace/Another(N-/)
    $cdpath
  )
