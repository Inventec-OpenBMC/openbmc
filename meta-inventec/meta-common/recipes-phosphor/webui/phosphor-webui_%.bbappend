do_compile() {
     cd ${S}
     rm -rf node_modules
     npm install -g npm  --proxy=${http_proxy} --https-proxy=${https_proxy}
     npm --loglevel info --proxy=${http_proxy} --https-proxy=${https_proxy} install
     npm run-script build
}
