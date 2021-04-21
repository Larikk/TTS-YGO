import requests
import json

class Client:
    def __init__(self, albumHash):
        with open("secrets", "r") as f:
            self.access_token = f.readline()
        self.albumHash = albumHash
        self.album = self.getAlbum(albumHash)

    def getAlbum(self, albumHash):
        url = "https://api.imgur.com/3/album/" + albumHash

        headers = {
            'Authorization': f'Bearer {self.access_token}'
        }

        response = requests.request("GET", url, headers=headers)

        #pretty_json = json.loads(response.text)
        #print(json.dumps(pretty_json, indent=4))

        album = response.json()
        return album

    def getUrl(self, name, imageSrc):
        imageOnImgur = self.__searchImageOnImgur(name)
        if imageOnImgur == None:
            print("Uploading image to imgur...")
            return self.__uploadImageToAlbum(name, imageSrc)
        else:
            print("Image is on imgur, skipping.")
            return imageOnImgur['link']

    def __searchImageOnImgur(self, description):
        images = self.album['data']['images']

        return next(filter(lambda e: e['description'] == description, images), None)

    def __uploadImageToAlbum(self, name, imageSrc):
        url = "https://api.imgur.com/3/image"

        payload={
            'image': imageSrc,
            'album': self.albumHash,
            'type': 'url',
            'description': name
        }
        headers = {
            'Authorization': f'Bearer {self.access_token}'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        return response.json()['data']['link']

    def updateAllDescriptions(self, descriptionProducer):
        images = self.album['data']['images']
        for image in images:
            description = descriptionProducer(image)

            url = f"https://api.imgur.com/3/image/{image['id']}"

            payload={
                'description': description
            }

            headers = {
                'Authorization': f'Bearer {self.access_token}'
            }

            response = requests.request("POST", url, headers=headers, data=payload)

            if not response.ok:
                print("Description Update failed")
                print(response.text)
                exit(1)
