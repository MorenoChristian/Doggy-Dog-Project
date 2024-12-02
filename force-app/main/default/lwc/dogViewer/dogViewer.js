import { LightningElement, track, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getAllFavorites from '@salesforce/apex/getFavoriteController.getFav';
import { createRecord } from 'lightning/uiRecordApi';
import { deleteRecord } from 'lightning/uiRecordApi';

export default class DogViewer extends LightningElement {

    @track images = []; // Array to store images received from child
    @track imageUrl;
    @track breed;
    @track subBreed;
    @wire(getAllFavorites) favorites;
    @track error;    

    handleDogImages(event) {
        this.images = event.detail.imgUrl;
        this.breed = event.detail.breed;
        this.subBreed = event.detail.subBreed;
        // console.log('Received images from child:', this.images);
        // console.log('SubBreed recieved from child:', this.subBreed);
    }

    handleDogImage(event){
        this.imageUrl = event.detail.imgUrl;
        // console.log('Received images url from child DogCard:', this.imageUrl);
    }

    createRecordHandler(){
        this.createFavoriteRecord();
    }
    
    createFavoriteRecord() {
        const fields = {
            Name: this.breed,
            imageUrl__c: this.imageUrl,
            Breed__c: this.breed,
            Sub_Breed__c: this.subBreed
        };

        const recordInput = { apiName: 'Favorite_Dog__c', fields };

        createRecord(recordInput)
            .then((favorite) => {
                console.log('Favorite created with Id: ', favorite.id);
                return refreshApex(this.favorites);
            })
            .catch((error) => {
                console.error('Error creating favorite: ', error);
            });
    }

    handleDeleteRecord(){
        this.deleteFavoriteRecord();
    }

    deleteFavoriteRecord() {
        if (this.favorites.data) {
            // Find the record to delete
            const recordToDelete = this.favorites.data.find((dog) => dog.imageUrl__c === this.imageUrl);
    
            if (recordToDelete) {
                deleteRecord(recordToDelete.Id)
                    .then(() => {
                        console.log('Record deleted successfully!');
                        this.setFavoriteToFalse(recordToDelete.imageUrl__c);
                        return refreshApex(this.favorites);
                    })
                    .catch((error) => {
                        console.error('Error deleting record:', error);
                        this.error = error;
                        return refreshApex(this.favorites);
                    });
            } else {
                console.error('Record not found for deletion');
            }
        } else {
            console.error('Favorites data not loaded');
        }
    }

    setFavoriteToFalse(url) {
        const dogCard = this.template.querySelector(`c-dog-card[data-id="${url}"]`);
        if (dogCard) {
            dogCard.starflag = false;
        }
    }
}