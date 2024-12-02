import { LightningElement, api, track} from 'lwc';

export default class DogCard extends LightningElement {
    @api imgPath;
    @api breed;
    @api subbreed;
    @api starflag = false;
    @api favorite = false;

    imageHandler(){
        const dogImageEvent = new CustomEvent('dogimage', {
            detail: {
                imgUrl: this.imgPath,
            }
        });
        this.dispatchEvent(dogImageEvent);
        
        if(!this.favorite){
            this.starflag = this.starflag ? false: true;
        }      
    }
}