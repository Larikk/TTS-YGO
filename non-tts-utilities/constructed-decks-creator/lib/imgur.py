import requests

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

        album = response.json()
        return album

    def getUrl(self, name):
        imageOnImgur = self.__searchImageOnImgur(name)
        if imageOnImgur == None:
            print("Uploading image to imgur...")
            return self.__uploadImageToAlbum(name)
        else:
            print("Image is on imgur, skipping.")
            return imageOnImgur['link']

    def __searchImageOnImgur(self, description):
        images = self.album['data']['images']

        return next(filter(lambda e: e['description'] == description, images), None)

    def __uploadImageToAlbum(self, deck):
        url = "https://api.imgur.com/3/image"

        payload={
            'image': deck['image'],
            'album': self.albumHash,
            'type': 'url',
            'description': deck['name']
        }
        headers = {
            'Authorization': f'Bearer {self.access_token}'
        }

        response = requests.request("POST", url, headers=headers, data=payload)

        return response.json()['data']['link']
