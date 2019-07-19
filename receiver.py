import discord
import datetime

client = discord.Client()
YOUR_TOKEN = ""
@client.event
async def on_ready():
    print('Logged in as: '+str(client.user.name))
    print('UserID: '+str(client.user.id))
    print('User: '+str(client.user))
    print('Email: '+str(client.user.email))
    


try:
    client.run(YOUR_TOKEN)
except Exception as e:
    print(e)
