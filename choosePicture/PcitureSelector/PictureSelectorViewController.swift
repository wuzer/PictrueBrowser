//
//  PictureSelectorViewController.swift
//  choosePicture
//
//  Created by Jefferson on 15/9/11.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PictureSelectorViewController: UICollectionViewController {
    
    // 图片数组
    lazy var images: [UIImage] = [UIImage]()
    
    // 当前选中照片索引
    private var currentIndex = 0
    
    // 最多照片选择数量
    private let maxImageCount = 9
    
    // MARK: - 便利构造函数
    init() {
        let flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
        
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.whiteColor()

        // Register cell classes
        self.collectionView!.registerClass(PictureSelectorViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count + (images.count == maxImageCount ? 0 : 1)
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PictureSelectorViewCell
        
        // Configure the cell
        cell.image = indexPath.item < images.count ? images[indexPath.item] : nil
//        cell.PictureDelegate = self
        
        return cell
    }
    
    // MARK: - 选择照片
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // 判断是否支持照片选择
        if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
             print("无法访问相册")
            return
        }
        
        // 记录当前选中照片索引
        currentIndex = indexPath.item
        
        // 访问相册
        let picker = UIImagePickerController()
        picker.delegate = self
        
        presentViewController(picker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension PictureSelectorViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    /// 选中照片代理方法
    ///
    /// - parameter picker:      照片选择控制器
    /// - parameter image:       选中的照片
    /// - parameter editingInfo: editingInfo 字典，需要将 picker 的 allowsEditing 设置为 true，适合用于头像选择
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let scaleImage = image.scaleImage(300)
        
        
        if currentIndex < images.count {
            images[currentIndex] = scaleImage
        } else {
            images.append(scaleImage)
        }
        
        collectionView?.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
}

 /// 代理协议
protocol PictureSelectorViewCellDelegate: NSObjectProtocol {
    
    func PictureSelectorViewCellDidRemoved(cell: PictureSelectorViewCell)
}

    // MARK: - 自定义cell
class PictureSelectorViewCell: UICollectionViewCell {
    
    /// 选中照片
    var image: UIImage? {
        didSet {
            if image == nil {
                pictrueButton.setImageName("compose_pic_add")
            } else {
                pictrueButton.setImage(image, forState: UIControlState.Normal)
            }
            removeButton.hidden = image == nil
        }
    }
    
    /// 删除照片代理
    weak var PictureDelegate: PictureSelectorViewCellDelegate?
    
    /// MARK: - 按钮监听方法
    // 删除照片
    @objc private func removePicture() {
        PictureDelegate?.PictureSelectorViewCellDidRemoved(self)
    }

    /// MARK: - 搭建界面
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// MARK: - ui设置
    private func setupUI() {
        // 添加控件
        contentView.addSubview(pictrueButton)
        contentView.addSubview(removeButton)
        
        // 自动布局
        pictrueButton.frame = bounds
        
        pictrueButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        
    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[button]-0-|", options: [], metrics: nil, views: ["button": removeButton]))
        
    contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[button]", options: [], metrics: nil, views: ["button": removeButton]))
        
        // 监听方法
       pictrueButton.userInteractionEnabled = false
        removeButton.addTarget(self, action: "removePicutre", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /// MARK: - 懒加载控件
    /// 照片按钮
    private lazy var pictrueButton: UIButton = {
        
        let button = UIButton(imageName: "compose_pic_add")
        button.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        return button
    }()
    /// 添加按钮
    private lazy var removeButton: UIButton = UIButton(imageName: "compose_photo_close")
}
