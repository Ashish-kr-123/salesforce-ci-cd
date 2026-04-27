import { LightningElement } from 'lwc';

export default class TextDisplay extends LightningElement {
    inputText = '';
    a='';

    handleInputChange(event){
        this.inputText =  event.target.value;
    }

    handleButtonClick(){
        this.a = this.inputText;
         console.log('you have entered :' + this.a); 
    }
}