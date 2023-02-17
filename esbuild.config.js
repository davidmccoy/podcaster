const path   = require('path')

const context = require("esbuild").context({
  entryPoints: ["application.ts"],
  bundle: true,
  outdir: path.join(process.cwd(), "app/assets/builds"),
  absWorkingDir: path.join(process.cwd(), "app/javascript"),
  publicPath: "/assets",
  assetNames: "[name]-[hash].digested",
  loader: {
    '.js': 'jsx',
    '.png': 'file',
    '.jpg': 'file',
    '.svg': 'file'
  },
}).then(context => {
  if (process.argv.includes("--watch")) {
    // Enable watch mode
    context.watch()
  } else {
    // Build once and exit if not in watch mode
    context.rebuild().then(result => {
      context.dispose()
    })
  }
}).catch(() => process.exit(1))
