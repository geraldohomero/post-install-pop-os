
# Pós-Instalação do Pop!_OS (22.04)

> PIPOS
> [24.04 Em Breve](https://github.com/geraldohomero/post-install-pop-os/issues/44)

Script de pós-instalação para a distribuição `Pop!_OS`, baseado no Ubuntu. O script contém verificação de internet e se o `wget` está instalado no dispositivo. Além disso, instala pacotes `apt`, `flatpak` e `deb`; atualiza repositórios e realiza limpeza do sistema.

---

> **Nota**: O script foi projetado para `Pop!_OS 22.04 (LTS)`, mas pode funcionar em outras distribuições `baseadas em Debian`. No entanto, tenha cautela e certifique-se da compatibilidade antes de executá-lo em outros sistemas.
> 
> Teste no Ubuntu 24.04 LTS foi bem-sucedido. Veja [Issue 61](https://github.com/geraldohomero/post-install-pop-os/issues/61)

> **Importante**: Embora o script vise automatizar tarefas de configuração, é essencial revisar o código e entender o que ele faz antes de executá-lo em sua máquina. **Certifique-se de fazer backup de dados críticos antes de prosseguir**. O script fornecido é para **fins educacionais** e **não possui garantia ou suporte**.

## 1. Download

Baixe toda a pasta "post-install-pop-os" contendo os arquivos de script para o local de sua preferência. Você pode clonar (para a pasta **Downloads**) o repositório usando Git ou baixá-lo como arquivo ZIP na página do repositório.

No terminal, execute:

bash

Copy

`git clone https://github.com/geraldohomero/post-install-pop-os.git $HOME/Downloads`

## 2. Torne os Scripts Executáveis

bash

Copy

`chmod +x $HOME/Downloads/post-install-pop-os/run.sh`

## 3. Execute o Script de Configuração Pós-Instalação

Execute o script `run.sh` para iniciar o processo de pós-instalação. O script executará automaticamente e tornará executáveis os scripts `post-install.sh` e `alias.sh`, instalando pacotes necessários e configurando aliases personalizados.

bash

Copy

`$HOME/Downloads/post-install-pop-os/run.sh`

**Ou simplesmente copie e cole o seguinte comando no terminal:**

bash

Copy

`git clone https://github.com/geraldohomero/post-install-pop-os.git $HOME/Downloads/post-install-pop-os chmod +x $HOME/Downloads/post-install-pop-os/run.sh $HOME/Downloads/post-install-pop-os/run.sh`

## 4. Siga as Instruções na Tela

O script de configuração exibirá mensagens coloridas e informativas durante o progresso das etapas de instalação e configuração. Pode ser necessário fornecer sua senha para operações que requerem privilégios administrativos.

## 5. Revise o Software e Aliases Instalados

Após a conclusão da configuração, você pode revisar o software e os aliases instalados no sistema. O script `post-install.sh` instala pacotes de software listados em sua configuração, enquanto `alias.sh` configura aliases personalizados.

## 6. Personalize Aliases e Programas Instalados (Opcional)

Você pode modificar ou adicionar aliases personalizados no script `src/alias.sh` para adequar-se ao seu fluxo de trabalho. Edite o array CUSTOM_ALIASES com os aliases desejados e execute o script `alias.sh` novamente para atualizar seu arquivo .bash_aliases. O mesmo princípio é válido para `src/post-install.sh` e os arrays de `flatpak` e `apt`.

bash

Copy

`CUSTOM_ALIASES=(     'alias <nomeDoAlias>="<o que ele faz>"'    .    .    . )`

## 7. Scripts Adicionais

Este script também adiciona `update.sh` e `syncthingStatus.sh` ao diretório home com permissões de execução para que seus aliases possam funcionar conforme pretendido. Consulte `run.sh` para mais informações.

## 8. Swap de Áudio

O script adicionará o script `swapAudio.sh` ao diretório home com permissões de execução para que seu alias possa funcionar conforme pretendido. Consulte `run.sh` e `/misc/swapAudio.sh` para mais informações.

## 9. Clonagem de Repositórios do GitHub

No script `src/githubClone.sh`, você pode clonar todos os repositórios de um usuário específico. Será solicitado que você `insira o nome de usuário` e o script clonará todos os repositórios desse usuári
