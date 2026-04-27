import { LightningElement, api } from 'lwc';

export default class FirstParComp extends LightningElement {

    @api firstText = 'first message';
    @api secondText = 'second message';
    @api thirdText = 'third message';
    @api fourthText = 'fourth message';
}