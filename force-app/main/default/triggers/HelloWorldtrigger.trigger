trigger HelloWorldtrigger on Account (before insert) {
        system.debug('hello world!');
}