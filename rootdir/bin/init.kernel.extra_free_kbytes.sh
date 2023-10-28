extra_free_kbytes_backup_enable=`getprop persist.vendor.spc.mi_extra_free_enable`
MIN_PERCPU_PAGELIST_HIGH_FRACTION=8

if [ "true" = ${extra_free_kbytes_backup_enable} ]; then
	echo `cat /proc/sys/vm/min_free_kbytes` " " `cat /proc/sys/vm/watermark_scale_factor` " -1" > /sys/kernel/mi_wmark/extra_free_kbytes
	cat /proc/sys/vm/lowmem_reserve_ratio > /proc/sys/vm/lowmem_reserve_ratio

	percpu_pagelist_high_fraction=`cat /proc/sys/vm/percpu_pagelist_high_fraction`
	new_percpu_pagelist_high_fraction=${percpu_pagelist_high_fraction}
	[ ${percpu_pagelist_high_fraction} -lt ${MIN_PERCPU_PAGELIST_HIGH_FRACTION} ] && new_percpu_pagelist_high_fraction=${MIN_PERCPU_PAGELIST_HIGH_FRACTION}
	let new_percpu_pagelist_high_fraction++
	echo ${new_percpu_pagelist_high_fraction} > /proc/sys/vm/percpu_pagelist_high_fraction
	echo ${percpu_pagelist_high_fraction} > /proc/sys/vm/percpu_pagelist_high_fraction

fi