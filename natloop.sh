printf "\nDetermining Number of Objects\n"
total=$(mgmt_cli -r true -d $DOMAIN show objects --format json |jq '.total')
printf "There are $total objects\n"

printf "\nDoing the Needful\n"
for I in $(seq 0 500 $total)
do
mgmt_cli -r true -d $DOMAIN show objects details-level full limit 500 offset $I --format json | jq --raw-output '.objects[] | select(."nat-settings"."auto-rule" == true) | .name' >>autonat-objects.txt
done
