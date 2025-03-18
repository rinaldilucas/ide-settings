# === Prior Configurations ===
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" # Enable Powerlevel10k instant prompt

# === Path Configurations ===
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH # Extend the default PATH with user-specific and local bin directories
export MANPATH="/usr/local/man:$MANPATH" # Set manual pages path

# === Oh My Zsh Settings ===
export ZSH="$HOME/.oh-my-zsh" # Path to your Oh My Zsh installation
ZSH_THEME="powerlevel10k/powerlevel10k" # Define the theme
PROMPT='%n@%m %2~ $(git_prompt_info)%# '
HIST_STAMPS="dd/mm/yyyy" # Set the CLI time format for history
plugins=(git zsh-autosuggestions zsh-syntax-highlighting) # Load Oh My Zsh plugins
source $ZSH/oh-my-zsh.sh # Load Oh My Zsh framework
source ~/.p10k.zsh # Load Powerlevel10k configuration

# === Environment Variables ===
export LANG=en_US.UTF-8 # Set language environment
export NPM_REGISTRY_TOKEN={TOKEN} # Set NPM registry authentication token
export CHROME_BIN='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe' # Configure Chrome binary for testing (WSL-specific path)

# === Editor Settings ===
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim' # Use vim for remote SSH sessions
else
  export EDITOR='nvim' # Use Neovim for local sessions
fi

# === External Tools ===
export NVM_DIR="$HOME/.nvm" # Set NVM (Node Version Manager) directory
source "$NVM_DIR/nvm.sh" # Load NVM if the script exists

# === Custom User Settings ===
source ~/alias.zshrc # Load custom aliases from a separate file
