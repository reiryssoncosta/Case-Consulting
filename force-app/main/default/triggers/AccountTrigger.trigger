trigger AccountTrigger on Account (after update) {
    new AccountHandler().run();
}