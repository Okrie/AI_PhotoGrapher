from .PredPicture import PredPicture
from PIL import Image
import numpy as np
import os
import base64, io
import json

class PredImages:
    '''
        PredImages Class
    '''

    def pred(self, image_name):
        print(os.path.realpath('.'))

        pred_model = PredPicture(model_path=f'{os.path.realpath(".")}/pred/model/model_1.h5', width=128, height=128, image_path=f'{os.path.realpath(".")}/pred/images/image_1.jpg')

        original_img = np.array(Image.open(f'{os.path.realpath(".")}/pred/pred_image/{image_name}.jpg'), dtype=np.uint8)

        predicted_img = pred_model.show_generated_images(get_count=3)

        original_color = pred_model.trans_rgb()

        target_color = pred_model.calculate_rgb_variation(predicted_img)

        # 결과물 출력
        transformed_image = pred_model.apply_color_transformation(original_img, original_color, target_color)

        print(target_color[0], target_color[1], target_color[2])
        print(original_color[0] / target_color[0], original_color[1] / target_color[1], original_color[2] / target_color[2])

        print("Filltered_IMG")
        for i in range(len(transformed_image)):
            image = Image.fromarray(transformed_image[i])
            image.save(f'{os.path.realpath(".")}\\pred\\results\\img{i}.jpg')

        data_jsons = [self.image_to_json(image) for image in transformed_image]  # 각 이미지를 JSON으로 변환합니다.

        return data_jsons
    
    # 3차원 numpy 배열을 이미지로 변환
    @staticmethod
    def nparray_to_image(nparray):
        return Image.fromarray(np.uint8(nparray))

    # 이미지를 base64로 인코딩
    @staticmethod
    def image_to_base64(image):
        buffered = io.BytesIO()
        image.save(buffered, format="JPEG")
        img_str = base64.b64encode(buffered.getvalue())
        return img_str.decode('utf-8')

    # 이미지 데이터를 base64로 인코딩하여 JSON으로 변환
    @staticmethod
    def image_to_json(nparray):
        image = PredImages.nparray_to_image(nparray)
        img_str = PredImages.image_to_base64(image)
        return json.dumps({'image': img_str})