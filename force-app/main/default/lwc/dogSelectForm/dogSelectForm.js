import { LightningElement, track } from 'lwc';
import getAllBreeds from '@salesforce/apex/getAllBreeds.getAll';
import getSubBreeds from '@salesforce/apex/getAllBreeds.getSubBreeds';
import getDogImages from '@salesforce/apex/getAllBreeds.getDogImages';
import getDogImagesByBreed from '@salesforce/apex/getAllBreeds.getDogImagesByBreed';

export default class DogSelectForm extends LightningElement {

    @track breedNames = [];
    @track subBreedNames = [];
    @track hasSubBreeds;
    @track breed;
    @track subBreed;
    @track images = [];
    
    connectedCallback(){
        this.fetchAllBreeds();
    }
    
    async fetchAllBreeds(){
        const result = await getAllBreeds({});
        const parsed = JSON.parse(result);

        this.breedNames = Object.keys(parsed.message); // List of breed names
        // console.log('BREED NAMES:', this.breedNames);
        // this.breedNames.forEach(function(breed){
        //     console.log(`Breed: `+breed);
        // });
        // Access the message object and its values
        //const breeds = Object.entries(parsed.message); // Returns an array of [key, value] pairs
    }

    handleBreedSelection(event){
        this.breed = event.target.value;
        this.fetchSubBreeds();
    }

    async fetchSubBreeds(){
        const result = await getSubBreeds({breed: this.breed});
        const parsed = JSON.parse(result);
        this.subBreedNames = parsed.message;
        if(this.subBreedNames.length > 0){
            this.hasSubBreeds = true;
        }else{
            this.hasSubBreeds = false;
            this.subBreed = '';
        }
    }

    handleSubBreedSelection(event){
        this.subBreed = event.target.value;
        //console.log('SUB BREED SELECTED: '+this.subBreed);
    }

    getDogsHandler(){
        this.fetchDogImages();
    }

    async fetchDogImages(){
        let result;

        if (this.hasSubBreeds) {
            try {
                result = await getDogImages({ breed: this.breed, subBreed: this.subBreed });
            } catch (error) {
                console.error('Failed to fetch dog images:', error);
                return;
            }
        } else {
            try {
                result = await getDogImagesByBreed({ breed: this.breed});
            } catch (error) {
                console.error('Failed to fetch dog images:', error);
                return;
            }
        }
        const parsed = JSON.parse(result);
        this.images = Object.values(parsed.message);
        // this.images.forEach(function(img){
        //     console.log(`Image Url: `+img);
        // });

        const dogImagesEvent = new CustomEvent('dogimages', {
            detail: {
                imgUrl: this.images,
                breed: this.breed,
                subBreed: this.subBreed
            }
        });
        this.dispatchEvent(dogImagesEvent);
    }
}