const Discord = require('discord.js');
const figlet = require('figlet');
const colors = require('colors');
const readline = require('readline');
const commando = require(`discord.js-commando`);

const config = require('./config.json');
const bot = new commando.Client({
    commandPrefix:'!!',
    owner: config.id
});

const cmdsArray = [
    "dmall <message>",
    "dmrole <role> <message>"
];

bot.on("ready", () => {
    clear();
    console.log('______________________')
    bot.user.setActivity('Crée par DATA.', { url: "Crée par DATA", type: 'watching' })
        .then(presence => console.log(`Logs de vos envois MP :`))
        .catch(console.error);
});


bot.on("error", (error) => {
    bot.login(config.token);
});

process.on('unhandledRejection', error => {
	console.error('Unhandled promise rejection:', error);
});

bot.registry.registerGroup('dms', 'help');
bot.registry.registerDefaults();
bot.registry.registerCommandsIn(__dirname + "/commands");

if (process.env.BOT_TOKEN) bot.login(process.env.BOT_TOKEN);
else bot.login(config.token);


function clear() {
    console.clear();
    console.log(figlet.textSync(" Bot SPAM Message ").green); // final, fixed [but not really], etc..?
    console.log(figlet.textSync("  Data ").green); // final, fixed [but not really], etc..?
	console.log("\n\nList des commande pour vos pub mp: \n                                                                                                                         \n→ !!dmall [Votre message de pub]");
	
    


}

/*
The only values that are not truthy in JavaScript are the following (a.k.a. falsy values):
null
undefined
0
"" (the empty string)
false
NaN
Si tu modifie le code tu est un vrai fils de chien
*/