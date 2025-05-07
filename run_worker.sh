service ssh start

# Continuously check until MASTER_ADDR is resolved
while true; do
    MASTER_IP=$(nslookup "$MASTER_ADDR" 2>/dev/null | awk '/^Address: / && !seen { print $2; seen=1 }')
    if [ -n "$MASTER_IP" ]; then
        echo "MASTER_ADDR resolved to: $MASTER_IP"
        break
    else
        echo "Waiting for $MASTER_ADDR to be resolved..."
        sleep 5
    fi
done

echo "Resolved MASTER_IP: $MASTER_IP"

ray start --address="${MASTER_IP:=0}:6379" 
sleep infinity