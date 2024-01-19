OUTPUT=no
if [[ $# -gt 0 && $1 == "-o" ]]; then
    OUTPUT=yes
fi
# echo "** OUTPUT=[$OUTPUT]"

# in case dir not exists, there is no dirsource files
function set_exec() {
    # echo "** \$1=[$1]"
    if ls $1 1>/dev/null 2>&1; then
        chmod +x $1
        if [ $OUTPUT == "yes" ]; then
            echo "[EXE]: $1"
        fi
    else
        if [ $OUTPUT == "yes" ]; then
            echo "[EXE]: $1  --no files"
        fi
    fi
}

set_exec "$CMDEX_HOME/*.sh"
set_exec "$CMDEX_HOME/sh/*.sh"
set_exec "$CMDEX_HOME/py/*.py"
set_exec "$CMDEX_HOME/py/cmds/*.py"
set_exec "$CMDEX_HOME/py/utils/*.py"

source $CMDEX_HOME/sh/__extensions.sh
set_extensions_exec
