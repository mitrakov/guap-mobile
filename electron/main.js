const { app, BrowserWindow } = require('electron')
const { fork } = require('child_process')
const ps = fork(`${__dirname}/server.js`)

function createWindow () {
  const win = new BrowserWindow({
    width: 500,
    height: 800,
    webPreferences: {
      webSecurity: false,
      nodeIntegration: true
    }
  })

  win.loadURL('http://localhost:21001');
}

app.whenReady().then(createWindow)

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    ps.kill()
    app.quit()
  }
})

app.on('before-quit', function() {
   if (process.platform === 'darwin') {
     ps.kill()
   }
})

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow()
  }
})
