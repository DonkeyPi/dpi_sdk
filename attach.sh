#!/bin/bash -e

vid=`cat .vagrant/machines/dpi-sdk/virtualbox/id`

array_count=0
array_meta=()
array_label=()

while read -r line
do
    # echo $line
    if [[ "$line" =~ UUID:[[:blank:]]*([[:print:]]*) ]]
    then
        # echo ${BASH_REMATCH[1]}
        uuid=${BASH_REMATCH[1]}
    fi
    if [[ "$line" =~ VendorId:[[:blank:]]*([[:print:]]*) ]]
    then
        # echo ${BASH_REMATCH[1]}
        vendorId=${BASH_REMATCH[1]}
    fi
    if [[ "$line" =~ ProductId:[[:blank:]]*([[:print:]]*) ]]
    then
        # echo ${BASH_REMATCH[1]}
        productId=${BASH_REMATCH[1]}
    fi
    if [[ "$line" =~ Manufacturer:[[:blank:]]*([[:print:]]*) ]]
    then
        # echo ${BASH_REMATCH[1]}
        manufacturer=${BASH_REMATCH[1]}
    fi
    if [[ "$line" =~ Product:[[:blank:]]*([[:print:]]*) ]]
    then
        # echo ${BASH_REMATCH[1]}
        product=${BASH_REMATCH[1]}
        array_count=$(($array_count+1))
        array_meta+=("$uuid $vendorId $productId")
        array_label+=("$manufacturer $product")
        echo $array_count $manufacturer $product
    fi
done < <(vboxmanage list usbhost)

echo -n "Select device to attach: "
read option
if [[ $option -ge 1 && $option -le $array_count ]]
then
    index=$((option-1))
    #1b9842f2-79e4-4526-95f7-e424a527b260 0x1b1c (1B1C) 0x1b39 (1B39)
    metas=(${array_meta[index]})
    # echo vboxmanage controlvm $vid usbattach $metas
    vboxmanage controlvm $vid usbattach $metas
else
    echo "Invalid selection."
fi
