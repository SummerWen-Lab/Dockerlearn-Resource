import cv2

# 读取图片
image = cv2.imread('test_image.jpg')

# 检查图片是否加载成功
if image is None:
    print("无法加载图片，请检查文件路径。")
else:
    # 显示图片
    cv2.imshow('Test Image', image)

    # 等待按键，按任意键关闭窗口
    cv2.waitKey(0)
    cv2.destroyAllWindows()
