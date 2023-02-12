const path = require('path')

require("esbuild").build({
  entryPoints: ["application.ts"],
  bundle: true,
  outdir: path.join(process.cwd(), "app/assets/builds"),
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  watch: process.argv.includes("--watch"),
  publicPath: "/assets",
  assetNames: "[name]-[hash].digested",
  loader: {
    '.js': 'jsx',
    '.png': 'file',
    '.jpg': 'file',
    '.svg': 'file'
  },
}).catch(() => process.exit(1))
