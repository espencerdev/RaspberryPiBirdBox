'use strict'
import gpiox from "@iiot2k/gpiox"
import {GetIrEnableData, GetIrPinNumData} from "./configUtil.ts"

let gpioLastEnabled : number = -1;

export async function UpdateGpioState(): Promise<void> {
    if((await GetIrEnableData()) == "1") {
	const activeIrPin : number = +(await GetIrPinNumData() ?? -1);
	if (gpioLastEnabled != activeIrPin && activeIrPin >= 0){
	    DeinitOld();
	    gpiox.init_gpio(activeIrPin, 3, false);
	    gpioLastEnabled = activeIrPin;
	}
        if (activeIrPin >= 0) {
	    gpiox.set_gpio(activeIrPin, true);
	}
    }
    else {
	DeinitOld();
        gpioLastEnabled = -1;
    }
}

export function DeinitOld(){
    if (gpioLastEnabled >= 0) {
	gpiox.set_gpio(gpioLastEnabled, false);
	gpiox.deinit_gpio(gpioLastEnabled);
    }
}
