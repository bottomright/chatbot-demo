let Launcher = {
    init() {
        if (document.readyState === 'complete') {
            this.launch();
        } else {
            window.addEventListener('load', Launcher.launch);
        }
    },

    launch() {
        const url = "http://localhost:4000/chatbot"
        const background = "#4635b8"
        const foreground = "#FFFFFF"
        const styles = `<style>
      #chatbot-iframe {overflow: hidden; 
                   background-color: #FFFFFF; 
                   box-shadow: rgba(0, 0, 0, 0.16) 0px 5px 40px; 
                   position: fixed;
                   right: 0;
                   width: 100%;
                   z-index: 9999999999;
      }
      #chatbot-launcher {
        -webkit-mask-size: contain;
        -webkit-mask-repeat: no-repeat;
        -webkit-mask-position: center;
        -webkit-mask-image: url(data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cGF0aCBkPSJNIDEwMCAwIEMgMjAgMCAwIDIwIDAgMTAwIEMgMCAxODAgMjAgMjAwIDEwMCAyMDAgQyAxODAgMjAwIDIwMCAxODAgMjAwIDEwMCBDIDIwMCAyMCAxODAgMCAxMDAgMCBaIi8+Cjwvc3ZnPg==);
        overflow: hidden;
        cursor: pointer;
        padding: 0;
        background-color: ${background};
        color: white;
        position: fixed;
        display: flex;
        justify-content: center;
        align-items: center;
        bottom: 20px;
        right: 20px;
        width: 48px;
        height: 48px;
        z-index: 9999998;
        border: medium;
        transition: transform 500ms cubic-bezier(0.33, 0.00, 0.00, 1.00);
      }
      #chatbot-launcher:hover {
        transform: scale(1.1);
      }
      #chatbot-launcher:active {
        transform: scale(0.9);
      }
      </style>`;
        document.head.insertAdjacentHTML('beforeend', styles);
        let logo = `<svg width="90px" height="90px" viewBox="0 0 90 90" fill-rule="evenodd"><path fill="${background}" d="M0 0h90v90H0z"/><path d="M77.263 48.606v4c-1.32 22.663-15.69 23.047-28.322 23.487a5.49 5.49 0 0 1-.282.007c-.012 0-.024 0-.035-.001l-.035.001a5.49 5.49 0 0 1-.282-.007C24.4 75.61 77.263 21.215 77.263 48.606z" fill="${foreground}" fill-rule="nonzero"/></svg>`;
        const chevronDown = `
      <svg width="30px" height="15px" viewBox="0 0 51 31" stroke="${foreground}" fill="none" stroke-linecap="round" stroke-width="9"><path d="M5.362 5.457l20.276 20.087"/><path d="M45.638 5.457L25.362 25.543"/></svg>`;
        const minWidth = '350';
        const iframe = document.createElement('iframe');
        iframe.setAttribute('id', 'chatbot-iframe');
        iframe.src = url
        iframe.style.display = 'none';
        resize()
        document.body.appendChild(iframe);
        const launcher = document.createElement('button');
        launcher.setAttribute('id', 'chatbot-launcher');
        launcher.innerHTML = logo;
        launcher.onclick = () => {
            if (iframe.style.display === 'none') {
                iframe.style.display = 'block';
                launcher.innerHTML = chevronDown;
            } else {
                iframe.style.display = 'none';
                launcher.innerHTML = logo;
            }
        };
        if (window.innerWidth >= minWidth || true) {
            document.body.appendChild(launcher);
        }
        window.addEventListener('resize', () => {
            resize();
        });

        launcher.style.display = 'none';
        iframe.addEventListener('load', () => {
            setTimeout(() => {
                launcher.innerHTML = chevronDown;
                launcher.style.display = 'flex';
                iframe.style.display = 'block';
            }, 0)
        })

        function resize() {
            iframe.style.borderRadius = '7px';
            iframe.style.paddingBottom = '0px';
            iframe.style.bottom = window.innerWidth < minWidth ? '0' : '5rem';
            if ('bottom_right' === 'bottom_left') {
                iframe.style.left = window.innerWidth < minWidth ? '0' : '1rem';
            } else {
                iframe.style.right = window.innerWidth < minWidth ? '0' : '1.25rem';
            }
            iframe.style.width = window.innerWidth < minWidth ? '100%' : '345px';
            iframe.style.height = window.innerWidth < minWidth ? '100%' : '60vh';
            iframe.style.maxHeight = '520px'
        }
    }
}

Launcher.init();
