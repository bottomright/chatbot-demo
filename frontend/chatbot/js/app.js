import Alpine from 'alpinejs'
import {Socket} from "phoenix"
import { LiveSocket } from "phoenix_live_view"

let hooks = {}
hooks.PushEvent = {
    mounted() {
        window.pushEventHook = this
    }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
    dom: {
        onBeforeElUpdated(from, to) {
            if (from._x_dataStack) {
                window.Alpine.clone(from, to);
            }
        },
    },
    hooks,
    params: { _csrf_token: csrfToken },
    metadata: {
        keydown: (event, element) => {
            return {
                shiftKey: event.shiftKey
            }
        }
    },
})

liveSocket.connect()
window.liveSocket = liveSocket
window.Alpine = Alpine
Alpine.start()
